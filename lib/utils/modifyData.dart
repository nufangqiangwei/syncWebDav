import 'dart:convert';

import 'package:sync_webdav/Net/myServer.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/model/model.dart';

Future<String?> uploadData(String tableName) async {
  if (globalParams.userId == -1) {
    return null;
  }

  List<dynamic> data;
  if (tableName == "password") {
    data = await uploadPasswordData();
  } else if (tableName == "notebook") {
    data = await Notebook().select().isModify.equals(true).toList();
  } else {
    throw "错误的表名 $tableName";
  }
  try {
    await pushDataToServer(data, tableName);
  } catch (e) {
    await SysLog(content: e.toString()).save();
    return "网络请求错误";
  }
  if (tableName == "password") {
    await Password().select().isModify.equals(true).update({"isModify": false});
  } else {
    await Notebook().select().isModify.equals(true).update({"isModify": false});
  }
  return null;
}

Future<List<Map<String,String>>> uploadPasswordData() async{
  var query = await Password().select().isModify.equals(true).toList();
  List<Map<String,String>> data=[];
  for (final i in query) {
    data.add({
      "webKey":i.webKey!,
      "fromData":i.value!,
    });
  }
  return data;
}


downloadData(){
  if (globalParams.userId == -1) {
    return null;
  }

}
