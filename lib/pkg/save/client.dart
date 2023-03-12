import 'dart:async';
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
    _getDb();
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
    await _getDb();
    _getWhereBaseModel();
    List<Map<String, dynamic>> queryData =
        (await _getDb()).selectData(model.tableName, _whereArgs);
    List<DbValue> result = [];

    for (var i = 0; i < queryData.length; i++) {
      result.add(model.fromMap(queryData[i]));
    }

    return result;
  }

  Future<DbValue> getModel() async {
    await _getDb();
    _getWhereBaseModel();
    DbValue result;
    if (model.isOnly) {
      List<dynamic> data = (await _getDb()).getBucket(model.tableName);
      if (data.isEmpty) {
        result = model.fromMap(null);
      } else {
        result = model.fromMap(data[0]);
      }
    } else {
      List<Map<String, dynamic>> query =
          (await _getDb()).selectData(model.tableName, _whereArgs);

      if (query.isNotEmpty) {
        result = model.fromMap(query[0]);
      } else {
        result = model.fromMap({});
      }
    }
    return result;
  }

  Future<DB> _getDb() async {
    DB db = DB.getInstance();
    await db.init();
    return db;
  }

  update({DbValue? modelData, Map<String, dynamic>? jsonData}) async {
    await _getDb();
    Map<String, dynamic> mapData = {};
    String indexField;
    if (modelData != null) {
      mapData = modelData.toMap();
      model = modelData.getModel();
    } else if (jsonData != null) {
      mapData = jsonData;
    }
    _getWhereBaseModel();

    try {
      indexField = model.indexField;
    } catch (e) {
      throw ("请先指定model");
    }
    if (model.isOnly) {
      (await _getDb()).updateOnlyRowTable(model.tableName, mapData);
      return;
    }
    if(mapData[indexField]!=null){
      _whereArgs.add(Method(
          table: model,
          field: indexField,
          method: "equal",
          value: mapData[indexField]));
    }


    (await _getDb()).update(model.tableName, _whereArgs, mapData);
  }

  insert({DbValue? modelData, Map<String, dynamic>? jsonData}) async {
    await _getDb();
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
      (await _getDb()).update(
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
    (await _getDb()).insertInto(model.tableName, [mapData]);
  }

  insertAll(
      {List<DbValue>? modelData, List<Map<String, dynamic>>? jsonData}) async {
    await _getDb();
    _getWhereBaseModel();
    List<Map<String, dynamic>> insertData = [];
    if (modelData != null) {
      for (final item in modelData) {
        insertData.add(item.toMap());
      }
    } else if (jsonData != null) {
      insertData = jsonData;
    }
    if (model.isOnly) {
      throw ("唯一数据无法执行批量插入");
    }
    (await _getDb()).insertInto(model.tableName, insertData);
  }

  updateAll(List<DbValue> modelData) async {
    await _getDb();
    for (var index = 0; index < modelData.length; index++) {
      DbValue data = modelData[index];
      (await _getDb()).update(
          data.getModel().tableName,
          [
            Method(
                table: data.getModel(),
                field: data.getModel().indexField,
                method: "equal",
                value: data.toMap()[data.getModel().indexField])
          ],
          data.toMap());
    }
  }

  _getWhereBaseModel() {
    try{
      if(model != null){
        return ;
      }
    }catch(e){
      if (_whereArgs.isEmpty) {
        throw ("请先指定主表");
      }
      DbModel cache = _whereArgs[0].table;
      for (var i in _whereArgs) {
        if (cache != i.table) {
          throw ("筛选条件里包含多个表，无法找到查询的主表");
        }
      }
      model = cache;
    }
  }

  lastModel()async{
    await _getDb();
    if (_whereArgs.isNotEmpty) {
      model = _whereArgs[0].table;
    }
    DbValue result;
    if (model.isOnly) {
      List<dynamic> data = (await _getDb()).getBucket(model.tableName);
      if (data.isEmpty) {
        result = model.fromMap(null);
      } else {
        result = model.fromMap(data[0]);
      }
    } else {
      List<Map<String, dynamic>> query =
          (await _getDb()).selectData(model.tableName, _whereArgs);

      if (query.isNotEmpty) {
        result = model.fromMap(query[query.length-1]);
      } else {
        result = model.fromMap({});
      }
    }
    return result;
  }
}

class DB {
  static DB? _instance;
  Map<String, List<Map<String, dynamic>>> _databaseData = {};
  late String filePath = "";
  late String saveType = "";

  init() async {
    if (saveType != "") {
      return;
    }
    Directory value;
    if (kIsWeb) {
      saveType = "cookies";
      throw ("未知的web平台");
    } else if (Platform.isAndroid) {
      saveType = "file";
      value = await getApplicationSupportDirectory();
      filePath = path.join(value.path, "data");
    } else if (Platform.isIOS || Platform.isMacOS) {
      saveType = "file";
      value = await getLibraryDirectory();
      filePath = path.join(value.path, "data");
    } else if (Platform.isWindows || Platform.isLinux) {
      saveType = "file";
      value = await getApplicationSupportDirectory();
      filePath = path.join(value.path, "data");
    } else if (Platform.isFuchsia) {
      throw ("未知的平台");
    }
    File f = File(filePath);
    if (!await f.exists()) {
      await f.create();
      await f.writeAsString("{}", flush: true);
      return;
    }
    String i = await f.readAsString();
    if (i == "") {
      await f.writeAsString("{}", flush: true);
      return;
    }
    Map<String, dynamic> cache = jsonDecode(i) as Map<String, dynamic>;
    for (var key in cache.keys) {
      List<dynamic> va = cache[key] as List<dynamic>;
      List<Map<String, dynamic>> ca = [];

      for (var index = 0; index < va.length; index++) {
        va[index] as Map<String, dynamic>;
        ca.add(va[index]);
      }
      _databaseData[key] = ca;
    }
    // if(databaseData["Instance of 'SysConfigModel'"]!=null){
    //   throw("错误的表名");
    // }
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
    File f = File(filePath);
    f.writeAsStringSync(jsonEncode(_databaseData));
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

  updateOnlyRowTable(String key, Map<String, dynamic> data) {
    var bucket = getBucket(key);
    if (bucket.isEmpty) {
      bucket.add(data);
    } else {
      for (String mapKey in data.keys) {
        bucket[0][mapKey] = data[mapKey];
      }
    }
    save();
  }

  List<Map<String, dynamic>> getBucket(String key) {
    // await g_dbInit.future;
    if (key == "Instance of 'SysConfigModel'") {
      throw ("错误");
    }
    List<Map<String, dynamic>> x = [];
    if (saveType == "") {
      throw ("尚未初始化");
    }
    dynamic i = _databaseData[key];
    if (i == null) {
      _databaseData[key] = x;
      i = _databaseData[key];
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
    if(data is bool) {
      value as bool;
      return data==value;
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
