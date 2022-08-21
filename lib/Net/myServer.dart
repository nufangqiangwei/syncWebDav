import 'package:dio/dio.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/model/model.dart';

// 'https://ouliguojiashengsiyi.xyz/'
const webHost = 'http://192.168.1.21:5000';
const webPathPrefix = '';

register(String userPubKey, String encryptStr) async {
  var response = await Dio().post<Map<String, dynamic>>(
      webHost + webPathPrefix + '/register',
      queryParameters: {"UserPubKey": userPubKey, "EncryptStr": encryptStr});

  globalParams.setWebConfig(
      response.data?['UserId'] as int,
      response.data?['WebPubKey'] as String,
      response.data?['EncryptStr'] as String);
}

Future<List<WebSite>> getWebSiteList() async {
  var response = await Dio().get<Map<String, dynamic>>(webHost + webPathPrefix + '/webList');
  var webSiteList = response.data?['data'] as List<dynamic>;
  List<WebSite> result = [];
  for (var i = 0; i < webSiteList.length; i++) {
    result.add(WebSite.fromMap(webSiteList[i]));
  }
  return result;
}

String getEncryptStr() {
  if (globalParams.publicKeyStr == "" || globalParams.privateKeyStr == "") {
    throw "尚未添加密钥";
  }
  return globalParams.userRSA.encodeString(globalParams.encryptStr);
}

pushDataToServer(String data, String dataType) async {
  Map<String, dynamic> requestData = {"EncryptStr": getEncryptStr()};
  requestData["UserData"] = globalParams.userRSA.encodeString(data);
  String webPath;
  if (dataType == "password") {
    webPath = '/SaveUserData';
  } else {
    webPath = '/SaveUserNote';
  }
  Response<Map<String, dynamic>> response =
      await Dio().post<Map<String, dynamic>>(webHost + webPathPrefix + webPath);
  if (response.statusCode != 200) {
    throw response.statusMessage ?? "备份数据失败";
  }
}
