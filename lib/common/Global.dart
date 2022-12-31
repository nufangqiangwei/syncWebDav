import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:sync_webdav/common/utils.dart';
import '../model/model.dart';
import '../utils/rsaUtils.dart';

class GlobalParams extends ChangeNotifier {
  String _appBarText = 'Flutter Demo Home Page';

  // web Setting params
  late int _userInfoId = 0;
  late int userId = -1;
  late String webPubKey = '';
  late String encryptStr = ''; // 加密字符串
  late String publicKeyStr = '';
  late String privateKeyStr = '';
  late RSAUtils userRSA;
  late int lastPushTime = 0;
  late int _webInfoId = 0;
  late int passwordVersion = 0;

  // webSite params
  late List<WebSite> _webSiteList = [];
  late double windowsWith = 0;
  late double windowsHeight = 0;

  String get appBarText => _appBarText;
  List<WebSite> get webSiteList => _webSiteList;

  Future<bool> initAppConfig() async {
    sleep(Duration(seconds:1));
    print("初始化数据");
    getUserInfo();
    getSyncWebInfo();
    await refreshWebSiteList();
    await loadRsaClient();
    return true;
  }


  refreshWebSiteList() async {
    _webSiteList =
         await WebSite().select().orderBy('id').toList();
    print("站点数${_webSiteList.length}");
  }

  getUserInfo() async {
    SysConfig? data =
        await SysConfig().select().key.equals("userInfo").toSingle();
    if (data == null) return;
    _userInfoId = data.id ?? 0;
    Map<String, dynamic> userInfo = jsonDecode(data.value!);
    userId = userInfo['userId'];
    webPubKey = userInfo['webPubKey'];
    encryptStr = userInfo['encryptStr'];
  }

  getSyncWebInfo() async {
    SysConfig? data =
        await SysConfig().select().key.equals("webInfo").toSingle();
    if (data == null) return;
    _webInfoId = data.id ?? 0;
    Map<String, dynamic> webInfo = jsonDecode(data.value!);
    passwordVersion = webInfo['passwordVersion'];
  }

  loadRsaClient()async{
    if (publicKeyStr == '') {
      publicKeyStr = await getSysConfig('publicKeyStr');
    }
    if (privateKeyStr == '') {
      privateKeyStr = await getSysConfig('privateKeyStr');
    }
    if (publicKeyStr == '' || privateKeyStr == '') {
      return false;
    }
    userRSA = RSAUtils(publicKeyStr, privateKeyStr);
  }

  setUserConfig(int userId, String webPubKey, String encryptStr) async {
    SysConfig data = SysConfig(id: _userInfoId, key: "userInfo", value: "");
    String val = jsonEncode(
        {"userId": userId, "webPubKey": webPubKey, "encryptStr": encryptStr});
    data.value = val;
    _userInfoId = await data.save() ?? 0;
    //////////////////////////////
    this.userId = userId;
    this.webPubKey = webPubKey;
    this.encryptStr = encryptStr;
  }

  setWebInfo(int passwordVersion) async {
    SysConfig data = SysConfig(id: _webInfoId, key: "webInfo", value: "");
    String val = jsonEncode({"passwordVersion": passwordVersion});
    data.value = val;
    _webInfoId = await data.save() ?? 0;
    //////////////////////////////
    this.passwordVersion = passwordVersion;
  }

  clearUserInfo() {
    userId = -1;
    encryptStr = '';
  }
}

GlobalParams globalParams = GlobalParams();
