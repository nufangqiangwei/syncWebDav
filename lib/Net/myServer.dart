
import 'package:dio/dio.dart';
import 'package:sync_webdav/common/Global.dart';
import '../model/JsonModel.dart';
import '../pkg/save/model.dart';
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
const webHost = 'http://127.0.0.1:5000';
const webPathPrefix = '';

register(String userPubKey, String encryptStr) async {
  var response = await Dio().post<Map<String, dynamic>>(
      webHost + webPathPrefix + '/register',
      data: {"UserPubKey": userPubKey, "EncryptStr": encryptStr});
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

