import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:sync_webdav/common/utils.dart';
import 'package:sync_webdav/utils/initData.dart';
import '../model/model.dart';
import 'encryption.dart';

class GlobalParams extends ChangeNotifier {
  String _appBarText = 'Flutter Demo Home Page';

  // web Setting params
  late int _userInfoId = 0;
  late int userId = -1;
  late String webPubKey = '';
  late String encryptStr = ''; // 加密字符串
  late String publicKeyStr = '';
  late String privateKeyStr = '';
  late RsaEncrypt userRSA = RsaEncrypt.initKey("", "");
  late int lastPushTime = 0;
  late int _webInfoId = 0;
  late int passwordVersion = 0;

  // webSite params
  late List<WebSite> _webSiteList = [];
  late double windowsWith = 0;
  late double windowsHeight = 0;

  String get appBarText => _appBarText;

  // ignore: non_constant_identifier_names
  ModifyAppBarText(String value) {
    _appBarText = value;
    notifyListeners();
  }

  List<WebSite> get webSiteList => _webSiteList;

  // ignore: non_constant_identifier_names
  ModifyWebSiteList(List<WebSite> value) {
    _webSiteList = value;
    notifyListeners();
  }

  refreshWebSiteList() async {
    _webSiteList = initWebSiteData;
        // await WebSite().select().orderBy('id').toList();
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

  Future<bool> initAppConfig() async {
    getUserInfo();
    getSyncWebInfo();
    await refreshWebSiteList();
    if (publicKeyStr == '') {
      publicKeyStr = await getSysConfig('publicKeyStr');
    }
    if (privateKeyStr == '') {
      privateKeyStr = await getSysConfig('privateKeyStr');
    }
    if (publicKeyStr == '' || privateKeyStr == '') {
      return false;
    }
    userRSA = RsaEncrypt.initKey(publicKeyStr, privateKeyStr);
    return true;
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
