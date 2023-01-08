import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

class Store {
  late String _fromTable = '';
  final List<Method> _whereArgs = [];
  Store(){getDb();}

  // 构建表达式
  Store select(List<Method>? args) {
    if (args != null) {
      _whereArgs.addAll(args);
    }
    return this;
  }

  Store from(String table) {
    return this;
  }

  Store orderBy() {
    return this;
  }

  // 查询结果
  Future<List<Map<String, dynamic>>> all<T>() async {
    if (_fromTable == "") {
      _fromTable = T.toString();
    }
    return getDb().selectData(_fromTable, _whereArgs);
  }

  Future<T> getModel<T>() async {
    if (_fromTable == "") {
      _fromTable = T.toString();
    }

    return null as T;
  }

  save() async {}

  DB getDb() {
    DB db = DB.getInstance();
    db.init();
    return db;
  }
}

class DB {
  static DB? _instance;
  Map<String, dynamic> data = {};
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
    print(filePath);
    File f = File(filePath);
    if (!await f.exists()){
      await f.create();
      await f.writeAsString("{}");
    }
    String i = await f.readAsString();
    print("文本内容是$i");
    data = jsonDecode(i);
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

  getBucket(String key) {
    if (saveType == "") {
      throw ("尚未初始化");
    }
    if (_isSave) {
      return;
    }
    dynamic i = data[key];
    if (i == null) {
      List<Map<String, dynamic>> x=[];
      i = x;
    }
    //
    // i ??= x;
    return i;
  }

  List<Map<String, dynamic>> selectData(String key, List<Method> methods) {
    var bucket = getBucket(key) as List<Map<String, dynamic>>;
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
  final String table;
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
  final String table;
  final String field;
  final String defaultValue;
  late String value = '';

  DbString({required this.table, required this.field, this.defaultValue = ''});

  Method equal(value) {
    return Method(table: table, field: field, method: "equal", value: value);
  }
}

class DbInt {
  final String table;
  final String field;
  final int defaultValue;

  DbInt({required this.table, required this.field, this.defaultValue = 0});
}

class DbBool {
  final String table;
  final String field;
  final bool defaultValue;

  DbBool({required this.table, required this.field, this.defaultValue = false});
}


