import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sync_webdav/common/staticVariable.dart';
import '../utils/rsaUtils.dart';
import '../pkg/save/client.dart';
import '../pkg/save/model.dart';

class GlobalParams extends ChangeNotifier {
  // web Setting params
  late int userId = -1;
  late String webPubKey = '';
  late String encryptStr = ''; // 加密字符串
  late String publicKeyStr = '';
  late String privateKeyStr = '';
  late RSAUtils userRSA;
  late int lastPushTime = 0;
  late int passwordVersion = 0;
  late SysConfig sysConfig = SysConfig.fromMap({});
  late String cachePath = '';

  // webSite params
  late List<WebSite> _webSiteList = [];
  late double windowsWith = 0;
  late double windowsHeight = 0;

  List<WebSite> get webSiteList => _webSiteList;

  Future<bool> initAppConfig() async {
    Store();
    sleep(const Duration(seconds:1));
    print("初始化数据");
    await getCachePath();
    await getUserInfo();
    await refreshWebSiteList();
    await loadRsaClient();
    return true;
  }

  getCachePath()async{
    if (kIsWeb) {
      throw ("未知的web平台");
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
       cachePath = (await getApplicationDocumentsDirectory()).path;
       print("pc平台缓存地址$cachePath");
    }else if(Platform.isAndroid || Platform.isIOS){
       cachePath = (await  getTemporaryDirectory()).path;
       print("移动平台缓存地址$cachePath");
    } else if (Platform.isFuchsia) {
      throw ("未知的平台");
    }
  }

  refreshWebSiteList() async {
    List<DbValue> queryData = await Store().from(WebSiteModel()).all();
    if(queryData is List<WebSite>){
      _webSiteList = queryData;
    }
    if (_webSiteList.isEmpty) {
      _webSiteList = InitWebData;
    }
    print("站点数${_webSiteList.length}");
  }

  getUserInfo() async {
    SysConfig config = await Store().from(SysConfigModel()).getModel() as SysConfig;
    sysConfig = config;
    userId = config.userId;
    webPubKey = config.webRsaPub;
    encryptStr = config.encryptStr;
    publicKeyStr = config.userRsaPub;
    privateKeyStr = config.userRsaPri;
    passwordVersion = config.passwordVersion;
  }

  loadRsaClient()async{
    if (publicKeyStr == '' || privateKeyStr == '') {
      return false;
    }
    userRSA = RSAUtils(publicKeyStr, privateKeyStr);
  }

  setUserConfig(int userId, String webPubKey, String encryptStr) async {
    sysConfig.userId=userId;
    sysConfig.webRsaPub=webPubKey;
    sysConfig.encryptStr=encryptStr;
    Store().update(modelData:sysConfig);
    //////////////////////////////
    this.userId = userId;
    this.webPubKey = webPubKey;
    this.encryptStr = encryptStr;
  }

  setWebInfo(int passwordVersion) async {
    sysConfig.passwordVersion=passwordVersion;
    Store().update(modelData:sysConfig);
    //////////////////////////////
    this.passwordVersion = passwordVersion;
  }

  setUserRsaKey(String pubKey,String priKey){
    publicKeyStr = pubKey;
    privateKeyStr = priKey;
    sysConfig.userRsaPub=pubKey;
    sysConfig.userRsaPri=priKey;
    Store().update(modelData:sysConfig);
  }

  clearUserInfo() {
    userId = -1;
    encryptStr = '';
  }
}

GlobalParams globalParams = GlobalParams();
