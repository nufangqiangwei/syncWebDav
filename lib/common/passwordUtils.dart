import 'dart:convert';

import 'package:sync_webdav/model/JsonModel.dart';
import '../pkg/save/model.dart';

import 'Global.dart';

Future<List<AccountData>> decodePassword(PassWord data) async {
  String s = "";
  if (data.value == '') {
    return [];
  }
  if (data.isEncryption) {
    if (globalParams.publicKeyStr == "" || globalParams.privateKeyStr == "") {
      throw "缺少密钥";
    }
    s = globalParams.userRSA.decryptRsa(data.value);
  } else {
    s = data.value;
  }
  List<AccountData> result = [];
  // print("decodePassword: $s");
  for (var i in json.decode(s)) {
    result.add(AccountData.fromJson(i as Map<String, dynamic>));
  }
  return result;
}

Future<PassWord> encodePassword(PassWord data, List<AccountData> detail) async {
  String encodeStr = json.encode(detail);
  if (globalParams.publicKeyStr == "" || globalParams.privateKeyStr == "") {
    data.value = encodeStr;
    data.isEncryption = false;
    return data;
  }
  data.value = globalParams.userRSA.encryptRsa(encodeStr);
  data.isEncryption = true;
  return data;
}
