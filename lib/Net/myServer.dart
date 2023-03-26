
import 'package:dio/dio.dart';
import 'package:sync_webdav/common/Global.dart';
import '../model/JsonModel.dart';
import 'package:sync_webdav/model/dbModel.dart';
import '../utils/rsaUtils.dart';

getEncryptStr(Map<String, dynamic> requestData) {
  if (globalParams.publicKeyStr == "" || globalParams.privateKeyStr == "") {
    throw "尚未添加密钥";
  }
  var webRsa = RSAUtils.initRsa(globalParams.webPubKey);
  int timestamp = DateTime.now().millisecondsSinceEpoch;
  String signed = globalParams.userRSA.sign(globalParams.encryptStr+timestamp.toString());
  String encryptStr = webRsa.encryptRsa('''{
    "UserId":${globalParams.userId},
    "Timestamp":$timestamp
  }''');

  requestData["EncryptStr"]=encryptStr;
  requestData["Signed"]=signed;
  return ;
}

// 'https://ouliguojiashengsiyi.xyz/'
const webHost = 'http://127.0.0.1';
const webPathPrefix = '';

register(String userPubKey, String encryptStr) async {
  var response = await Dio().post<Map<String, dynamic>>(
      webHost + webPathPrefix + '/register',
      data: {"UserPubKey": userPubKey, "EncryptStr": encryptStr});
  if (response.statusCode != 200) {
    throw response.statusMessage ?? "注册失败";
  }
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
    WebSite a = WebSite()
    ..icon = webSiteList[i]["icon"]
    ..name = webSiteList[i]["name"]
    ..webKey = webSiteList[i]["webKey"]
    ..url = webSiteList[i]["url"];
    result.add(a);
  }
  return result;
}

//  需要登录的接口
pushDataToServer(data, String dataType) async {
  Map<String, dynamic> requestData = {
    "DataType": dataType,
    "UserData": data,
  };
  getEncryptStr(requestData);
  Response<Map<String, dynamic>> response = await Dio()
      .post<Map<String, dynamic>>(webHost + webPathPrefix + '/SaveUserData',
          data: requestData);
  if (response.statusCode != 200) {
    throw response.statusMessage ?? "备份数据失败";
  }
}

Future<List<ServerGetPasswordDataResponse>> getPasswordData([int? version]) async {
  Map<String, dynamic> requestData = {
    "DataType":"password",
  };
  getEncryptStr(requestData);
  Response<Map<String, dynamic>> response = await Dio()
      .post<Map<String, dynamic>>(webHost + webPathPrefix + "/GetUserData",
          data: requestData);
  if (response.statusCode != 200) {
    throw response.statusMessage ?? "获取备份失败";
  }
  // if (response.data!['version'] != version) {
  //   throw "获取备份失败,返回的不是指定的版本";
  // }
  List<ServerGetPasswordDataResponse> data =[];
  for (var i = 0; i < response.data!['data'].length; i++) {
    data.add(ServerGetPasswordDataResponse.fromJson(response.data!['data'][i]));
  }
  return data;
}

/*
github.com,140.82.113.3 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
[ssh.github.com]:443,[20.205.243.160]:443 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=

*/