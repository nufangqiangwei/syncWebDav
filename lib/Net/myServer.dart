import 'package:dio/dio.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/model/model.dart';

String getEncryptStr() {
  if (globalParams.publicKeyStr == "" || globalParams.privateKeyStr == "") {
    throw "尚未添加密钥";
  }
  return globalParams.userRSA.encodeString(globalParams.encryptStr);
}

// 'https://ouliguojiashengsiyi.xyz/'
const webHost = 'http://127.0.0.1:5000';
const webPathPrefix = '';

register(String userPubKey, String encryptStr) async {
  var response = await Dio().post<Map<String, dynamic>>(
      webHost + webPathPrefix + '/register',
      data: {"UserPubKey": userPubKey, "EncryptStr": encryptStr});
  print(response);
  globalParams.setUserConfig(
      response.data?['userId'] as int,
      response.data?['webPubKey'] as String,
      response.data?['encryptStr'] as String);
}

Future<List<WebSite>> getWebSiteList() async {
  var response = await Dio()
      .get<Map<String, dynamic>>(webHost + webPathPrefix + '/webList');
  var webSiteList = response.data?['data'] as List<dynamic>;
  List<WebSite> result = [];
  for (var i = 0; i < webSiteList.length; i++) {
    result.add(WebSite.fromMap(webSiteList[i]));
  }
  return result;
}

//  需要登录的接口
pushDataToServer(String data, String dataType) async {
  Map<String, dynamic> requestData = {"EncryptStr": getEncryptStr()};
  requestData["UserData"] = globalParams.userRSA.encodeString(data);
  String webPath;
  if (dataType == "password") {
    webPath = '/SaveUserData';
  } else {
    webPath = '/SaveUserNote';
  }
  Response<Map<String, dynamic>> response = await Dio()
      .post<Map<String, dynamic>>(webHost + webPathPrefix + webPath,
          data: requestData);
  if (response.statusCode != 200) {
    throw response.statusMessage ?? "备份数据失败";
  }
}

Future<List<Map<String, String>>> getPasswordData(int version) async {
  Map<String, dynamic> requestData = {
    "EncryptStr": getEncryptStr(),
    "Version": version,
  };
  Response<Map<String, dynamic>> response = await Dio()
      .post<Map<String, dynamic>>(webHost + webPathPrefix + "/GetUserData",
          data: requestData);
  if (response.statusCode != 200) {
    throw response.statusMessage ?? "获取备份失败";
  }
  if (response.data!['version'] != version) {
    throw "获取备份失败,返回的不是指定的版本";
  }
  List<Map<String, String>> data =
      response.data!['data'] as List<Map<String, String>>;
  return data;
}

Future<Map<String, List<int>>> getDataVersion() async {
  Map<String, dynamic> requestData = {
    "EncryptStr": getEncryptStr(),
    "dataType": "password",
  };
  Response<Map<String, dynamic>> response = await Dio()
      .post<Map<String, dynamic>>(webHost + webPathPrefix + "/GetUserData",
          data: requestData);
  if (response.statusCode != 200) {
    throw response.statusMessage ?? "获取版本号失败";
  }
  Map<String, List<int>> data =
      response.data!['data'] as Map<String, List<int>>;
  return data;
}
