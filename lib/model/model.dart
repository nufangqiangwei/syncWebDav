import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'model.g.dart';

class BundledDbModel extends SqfEntityModelProvider {}

initDatabase()async{
  convertDatabaseToModelBase(BundledDbModel()
    ..databaseName = 'PasswordManage.db'
    ..bundledDatabasePath = 'assets/database/PasswordManage.db');
}

// flutter pub run build_runner build --delete-conflicting-outputs
const tableSysConfig = SqfEntityTable(
  tableName: 'sysConfig',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  // 是否保留删除
  useSoftDeleting: true,
  fields: [
    SqfEntityField('key', DbType.text, isNotNull: true, isIndex: true),
    SqfEntityField('value', DbType.text, isNotNull: true),
  ],
);

const tableWebSite = SqfEntityTable(
  tableName: 'webSite',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  fields: [
    SqfEntityField('icon', DbType.text, isNotNull: false, defaultValue: ''),
    SqfEntityField('name', DbType.text, isNotNull: true, defaultValue: ''),
    SqfEntityField('url', DbType.text, isNotNull: false, defaultValue: ''),
    SqfEntityField('webKey', DbType.text, isNotNull: false, defaultValue: ''),
  ],
);

const tablePassWord = SqfEntityTable(
  tableName: 'password',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  fields: [
    SqfEntityField('webKey', DbType.text, isNotNull: false),
    SqfEntityField('value', DbType.text, isNotNull: true),
    SqfEntityField('version', DbType.integer, isNotNull: false),
    SqfEntityField('isModify', DbType.bool, defaultValue: false),
    SqfEntityField('isEncryption', DbType.bool, defaultValue: false),
  ],
);

const tableNoteBook = SqfEntityTable(
    tableName: 'notebook',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
      SqfEntityField('isImportant', DbType.bool, isNotNull: false),
      SqfEntityField('number', DbType.integer, isNotNull: false),
      SqfEntityField('title', DbType.text, isNotNull: false),
      SqfEntityField('description', DbType.text, isNotNull: false),
      SqfEntityField('isModify', DbType.bool, defaultValue: false),
    ],
);

const tableSysLog = SqfEntityTable(
  tableName: 'sysLog',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
    fields:[
      SqfEntityField('content', DbType.text, isNotNull: false),
    ]
);

@SqfEntityBuilder(databaseModel)
const databaseModel = SqfEntityModel(
    modelName: 'MyPasswordManage',
    databaseName: 'PasswordManage.db',
    bundledDatabasePath: 'assets/database/PasswordManage.db',
    password: null,
    databaseTables: [
      tableSysConfig,
      tableWebSite,
      tablePassWord,
      tableNoteBook,
      tableSysLog
    ],
    // formTables: [tableSysConfig],
    dbVersion: 2,
    // 指定数据库位置，null则框架兴建一个文件 例：'assets/sample.db'
    // bundledDatabasePath: 'assets/database/PasswordManage.db',
    // 指定绝对目录，不传则调用 sqflite.getDatabasesPath() 获取
    databasePath: null,
    defaultColumns: [
      SqfEntityField('dateCreated', DbType.datetime,
          defaultValue: 'DateTime.now()'),
    ],
    // preSaveAction: modelSaveEvent,
);

Future<TableBase> modelSaveEvent(String tableName, TableBase model) async {
  if(!model.isInsert && (tableName=="password"||tableName=="notebook")){
    if (tableName=="password"){
      model as Password;
      if (model.isModify==null || model.isModify==false){
        model.isModify=true;
      }
    }else{
      model as Notebook;
      if (model.isModify==null || model.isModify==false){
        model.isModify=true;
      }
    }
  }
  return model;
}
