import 'dart:convert';

import 'package:sync_webdav/model/JsonModel.dart';
import 'package:sync_webdav/model/model.dart';

import 'Global.dart';

Future<List<AccountData>> decodePassword(Password data) async {
  String s = "";
  print("解密密码：${data.value}");
  if (data.value == null) {
    return [];
  }
  if (data.isEncryption ?? false) {
    if (globalParams.publicKeyStr == "" || globalParams.privateKeyStr == "") {
      throw "缺少密钥";
    }
    s = globalParams.userRSA.decodeString(data.value!);
  } else {
    s = data.value ?? "[]";
  }
  List<AccountData> result = [];
  print("decodePassword: $s");
  for (var i in json.decode(s)) {
    result.add(AccountData.fromJson(i as Map<String, dynamic>));
  }
  return result;
}

Future<Password> encodePassword(Password data, List<AccountData> detail) async {
  String encodeStr = json.encode(detail);
  if (globalParams.publicKeyStr == "" || globalParams.privateKeyStr == "") {
    data.value = encodeStr;
    data.isEncryption = false;
    return data;
  }
  data.value = globalParams.userRSA.encodeString(encodeStr);
  data.isEncryption = true;
  return data;
}
