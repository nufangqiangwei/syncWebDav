import 'dart:convert';

import 'package:sync_webdav/common/utils.dart';
import 'package:sync_webdav/model/JsonModel.dart';

import 'Global.dart';

Future<List<PassWordData>> getWebSitePassword(String webSiteName) async {
  String encodeData = await getWebSiteData(webSiteName);
  print(encodeData);
  if (encodeData.isEmpty) {
    return [];
  }
  if (globalParams.publicKeyStr == "" || globalParams.privateKeyStr == "") {
    throw "缺少密钥";
  }


  var decodeData = globalParams.userRSA.decodeString(encodeData);
  List<PassWordData> result = [];
  for(var i in json.decode(decodeData)){
    result.add(PassWordData.fromJson(i as Map<String,dynamic>));
  }
  return result;
}


Future<String> encodeData(List<PassWordData> data) async {
  if (globalParams.publicKeyStr == "" || globalParams.privateKeyStr == "") {
    throw "缺少密钥";
  }
  String encodeStr = json.encode(data);
  print("解密完成");
  return globalParams.userRSA.encodeString(encodeStr);
}


