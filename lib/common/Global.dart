import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sync_webdav/common/staticVariable.dart';
import '../pkg/save/client.dart';
import '../pkg/save/model.dart';
import '../utils/rsaUtils.dart';

class GlobalParams extends ChangeNotifier {
  final Map<String, List<VoidCallback>> _fieldCallback = {};
  late SysConfig _sysConfig = SysConfig.fromMap({"userId": -1});

  // web Setting params
  int get userId => _sysConfig.userId;

  String get webPubKey => _sysConfig.webRsaPub;

  String get encryptStr => _sysConfig.encryptStr; // 加密字符串
  set encryptStr(String data) =>
      setUserConfig(_sysConfig.userId, _sysConfig.webRsaPub, data);

  String get publicKeyStr => _sysConfig.userRsaPub;

  String get privateKeyStr => _sysConfig.userRsaPri;

  late RSAUtils userRSA;
  late int lastPushTime = 0;
  late int passwordVersion = 0;
  late String cachePath = '';

  // webSite params
  late List<WebSite> _webSiteList = [];
  late double windowsWith = 0;
  late double windowsHeight = 0;

  List<WebSite> get webSiteList => _webSiteList;

  Future<bool> initAppConfig() async {
    // Store();
    sleep(const Duration(seconds: 1));
    print("初始化数据");
    await getCachePath();
    await getUserInfo();
    await refreshWebSiteList();
    await loadRsaClient();
    return true;
  }

  getCachePath() async {
    if (kIsWeb) {
      throw ("未知的web平台");
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      cachePath = (await getApplicationDocumentsDirectory()).path;
      print("pc平台缓存地址$cachePath");
    } else if (Platform.isAndroid || Platform.isIOS) {
      cachePath = (await getTemporaryDirectory()).path;
      print("移动平台缓存地址$cachePath");
    } else if (Platform.isFuchsia) {
      throw ("未知的平台");
    }
  }

  refreshWebSiteList() async {
    List<DbValue> queryData = await Store().from(WebSiteModel()).all();
    if (queryData is List<WebSite>) {
      _webSiteList = queryData;
    }
    if (_webSiteList.isEmpty) {
      _webSiteList = InitWebData;
    }
    print("站点数${_webSiteList.length}");
  }

  getUserInfo() async {
    SysConfig config =
        await Store().from(SysConfigModel()).getModel() as SysConfig;
    _sysConfig = config;
  }

  loadRsaClient() async {
    if (publicKeyStr == '' || privateKeyStr == '') {
      return false;
    }
    userRSA = RSAUtils.initRsa(publicKeyStr, privateKeyStr);
  }

  setUserConfig(int userId, String webPubKey, String encryptStr) async {
    _sysConfig.userId = userId;
    _sysConfig.webRsaPub = webPubKey;
    _sysConfig.encryptStr = encryptStr;
    await Store().update(modelData: _sysConfig);
  }

  setWebInfo(int passwordVersion) async {
    _sysConfig.passwordVersion = passwordVersion;
    await Store().update(modelData: _sysConfig);
    //////////////////////////////
    this.passwordVersion = passwordVersion;
  }

  setUserRsaKey(String pubKey, String priKey)async {
    _sysConfig.userRsaPub = pubKey;
    _sysConfig.userRsaPri = priKey;
    await Store().update(modelData: _sysConfig);
  }

  clearUserInfo() {}

  listingFieldModify(String fieldName, VoidCallback callback) {
    if (!_fieldCallback.containsKey(fieldName)) {
      _fieldCallback[fieldName] = [];
    }
    _fieldCallback[fieldName]?.add(callback);
  }
}

GlobalParams globalParams = GlobalParams();
