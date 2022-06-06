import 'dart:convert';

import 'package:sync_webdav/common/utils.dart';
import 'package:sync_webdav/model/JsonModel.dart';
import 'package:sync_webdav/model/class.dart';

import 'Global.dart';
import 'encryption.dart';

Future<List<PassWordData>> getWebSitePassword(String webSiteName) async {
  String encodeData = await getWebSiteData(webSiteName);
  if (GlobalParams.publicKeyStr == '') {
    await globalParams.initPasswordData();
  }
  if (GlobalParams.publicKeyStr == '') {
    throw "缺少密钥";
  }
  RsaEncrypt rsa =
      RsaEncrypt.initKey(GlobalParams.publicKeyStr, GlobalParams.privateKeyStr);

  var decodeData = await rsa.decodeString(encodeData);

  return DecodePassWordData.fromJson(json.decode(decodeData)).data as List<PassWordData>;
}



