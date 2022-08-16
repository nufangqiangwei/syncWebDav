import 'dart:convert';

import 'package:sync_webdav/Net/myServer.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/model/model.dart';

uploadData(String tableName)async {
  globalParams.userId;

  List<dynamic> data;
  if (tableName=="password") {
   data = await Password().select().isModify.equals(true).toList();
  }else if(tableName=="notebook") {
    data = await Notebook().select().isModify.equals(true).toList();
  }else{
  throw "错误的表名 $tableName";
  }
  try{
    await pushDataToServer(jsonEncode({"saveType":tableName,"data":data}),tableName);
  }catch(e){
    await SysLog(content: e.toString()).save();
    return ;
  }
  if (tableName=="password"){
    await Password().select().isModify.equals(true).update({"isModify":false});
  }else{
    await Notebook().select().isModify.equals(true).update({"isModify":false});
  }
}
