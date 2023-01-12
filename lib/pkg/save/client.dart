import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

import 'model.dart';

class Store {
  final List<Method> _whereArgs = [];
  late DbModel model;

  Store() {
    getDb();
  }

  // 构建表达式
  Store select(List<Method>? args) {
    if (args != null) {
      _whereArgs.addAll(args);
    }
    return this;
  }

  Store from(DbModel table) {
    model = table;
    return this;
  }

  Store orderBy() {
    return this;
  }

  // 查询结果
  Future<List<DbValue>> all() async {
    if (_whereArgs.isNotEmpty) {
      model = _whereArgs[0].table;
    }
    List<Map<String, dynamic>> queryData =
    (await getDb()).selectData(model.tableName, _whereArgs);
    List<DbValue> result = [];

    for (var i = 0; i < queryData.length; i++) {
      result.add(model.fromMap(queryData[i]));
    }

    return result;
  }

  Future<DbValue> getModel() async {
    if (_whereArgs.isNotEmpty) {
      model = _whereArgs[0].table;
    }
    DbValue result;
    if (model.isOnly) {
      result = model.fromMap((await getDb()).getBucket(model.toString())[0]);
    } else {
      result = model
          .fromMap((await getDb()).selectData(model.tableName, _whereArgs)[0]);
    }
    return result;
  }

  Future<DB> getDb() async {
    DB db = DB.getInstance();
    await db.init();
    return db;
  }

  update({DbValue? modelData, Map<String, dynamic>? jsonData}) async {
    Map<String, dynamic> mapData = {};
    String indexField;
    if (modelData != null) {
      mapData = modelData.toMap();
      model = modelData.getModel();
    } else if (jsonData != null) {
      mapData = jsonData;
    }

    try {
      indexField = model.indexField;
    } catch (e) {
      throw ("请先指定model");
    }
    _whereArgs.add(Method(
        table: model,
        field: indexField,
        method: "equal",
        value: mapData[indexField]));

    (await getDb()).update(model.tableName, _whereArgs, mapData);
  }

  insert({DbValue? modelData, Map<String, dynamic>? jsonData}) async {
    Map<String, dynamic> mapData = {};
    String indexField;
    if (modelData != null) {
      mapData = modelData.toMap();
      model = modelData.getModel();
    } else if (jsonData != null) {
      mapData = jsonData;
    }

    indexField = model.indexField;
    // try{
    //   indexField = model.indexField;
    // }catch (e){
    //   throw Exception("请先指定model");
    // }

    if (mapData[indexField] == null) {
      throw "索引健不能为空";
    }

    if (model.isOnly) {
      (await getDb()).update(
          model.tableName,
          [
            Method(
                table: model,
                field: indexField,
                method: "equal",
                value: mapData[indexField])
          ],
          mapData);
      return;
    }
    (await getDb()).insertInto(model.tableName, [mapData]);
  }

  insertAll(
      {List<DbValue>? modelData, List<Map<String, dynamic>>? jsonData}) async {
    List<Map<String, dynamic>> insertData = [];
    if (modelData != null) {
      insertData = modelData.map<Map<String, dynamic>>((e) => e.toMap())
      as List<Map<String, dynamic>>;
      model = modelData[0].getModel();
    } else if (jsonData != null) {
      insertData = jsonData;
    }
    if (model.isOnly) {
      throw ("唯一数据无法执行批量插入");
    }
    (await getDb()).insertInto(model.tableName, insertData);
  }

  updateAll(List<DbValue> modelDatas)async{
    for(var index=0;index<modelDatas.length;index++) {
      DbValue data = modelDatas[index];
      (await getDb()).update(data.getModel().tableName, [Method(
          table: data.getModel(),
          field: data.getModel().indexField,
          method: "equal",
          value: data.toMap()[data.getModel().indexField])], data.toMap());
    }
  }
}

class DB {
  static DB? _instance;
  Map<String, List<Map<String, dynamic>>> data = {};
  late bool _isSave = false;
  late String filePath = "";
  late String saveType = "";

  init() async {
    if (saveType != "") {
      return;
    }
    if (kIsWeb) {
      saveType = "cookies";
      throw ("未知的web平台");
    } else if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isWindows ||
        Platform.isLinux ||
        Platform.isMacOS) {
      saveType = "file";
      var value = await getApplicationDocumentsDirectory();
      filePath = path.join(value.path, "data");
    } else if (Platform.isFuchsia) {
      throw ("未知的平台");
    }
    File f = File(filePath);
    if (!await f.exists()) {
      await f.create();
      await f.writeAsString("{}");
    }
    String i = await f.readAsString();
    Map<String, dynamic> cache = jsonDecode(i) as Map<String, dynamic>;
    for (var key in cache.keys) {
      List<dynamic> va = cache[key] as List<dynamic>;
      List<Map<String, dynamic>> ca = [];

      for (var index = 0; index < va.length; index++) {
        va[index] as Map<String, dynamic>;
        ca.add(va[index]);
      }

      data[key] = ca;
    }
  }

  DB._();

  static DB getInstance() {
    _instance ??= DB._();
    return _instance!;
  }

  save() {
    if (saveType == "") {
      throw ("尚未初始化");
    }
    _isSave = true;
    File f = File(filePath);
    f.writeAsString(jsonEncode(data));

    _isSave = false;
  }

  insertInto(String key, List<Map<String, dynamic>> data) {
    getBucket(key).addAll(data);
    save();
  }

  update(String key, List<Method> methods, Map<String, dynamic> data) {
    var bucket = getBucket(key);
    for (var i = 0; i < bucket.length; i++) {
      if (!checkData(bucket[i], methods)) {
        continue;
      }
      for (var key in data.keys) {
        bucket[i][key] = data[key];
      }
    }
    save();
  }

  List<Map<String, dynamic>> getBucket(String key) {
    List<Map<String, dynamic>> x = [];
    if (saveType == "") {
      throw ("尚未初始化");
    }
    if (_isSave) {
      return x;
    }
    dynamic i = data[key];
    if (i == null) {
      data[key] = x;
      i = data[key];
    }
    return i;
  }

  List<Map<String, dynamic>> selectData(String key, List<Method> methods) {
    var bucket = getBucket(key);
    List<Map<String, dynamic>> result = [];
    for (var i = 0; i < bucket.length; i++) {
      if (!checkData(bucket[i], methods)) {
        continue;
      }
      result.add(bucket[i]);
    }
    return result;
  }

  bool checkData(Map<String, dynamic> data, List<Method> methods) {
    for (final i in methods) {
      if (!i.check(data)) {
        return false;
      }
    }
    return true;
  }
}

class Method {
  final DbModel table;
  final String field;
  final String method;
  final dynamic value;

  Method(
      {required this.table,
        required this.field,
        required this.method,
        required this.value});

  check(Map<String, dynamic> data) {
    var value = data[field];
    switch (method) {
      case "equal":
        return equal(value);
      case "moreThan":
        return moreThan(value);
    }
  }

  bool equal(dynamic data) {
    if (data is String) {
      value as String;
      return data == value;
    }
    if (data is int) {
      value as int;
      return data == value;
    }
    if (data is double) {
      value as double;
      return data == value;
    }
    return false;
  }

  bool moreThan(dynamic data) {
    if (data is String) {
      value as String;
      return data.hashCode <= value.hashCode;
    }
    if (data is int) {
      value as int;
      return data <= value;
    }
    if (data is double) {
      value as double;
      return data <= value;
    }
    return false;
  }
}

class DbString {
  final DbModel table;
  final String field;
  final String defaultValue;

  DbString({required this.table, required this.field, this.defaultValue = ''});

  Method equal(String value) {
    return Method(table: table, field: field, method: "equal", value: value);
  }
}

class DbInt {
  final DbModel table;
  final String field;
  final int defaultValue;

  DbInt({required this.table, required this.field, this.defaultValue = 0});

  Method equal(int value) {
    return Method(table: table, field: field, method: "equal", value: value);
  }
}

class DbBool {
  final DbModel table;
  final String field;
  final bool defaultValue;

  DbBool({required this.table, required this.field, this.defaultValue = false});

  Method equal(bool value) {
    return Method(table: table, field: field, method: "equal", value: value);
  }
}



/*

每月固定支出：
  房租：1600
  房贷：1800
购买大件：
  自行车：4300

*/