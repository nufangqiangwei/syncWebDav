import 'package:flutter/material.dart';
import 'package:sync_webdav/common/utils.dart';
import '../model/model.dart';
import 'encryption.dart';

class GlobalParams extends ChangeNotifier {
  String _appBarText = 'Flutter Demo Home Page';

  // web Setting params
  late int userId = 5;
  late String webPubKey = '';
  late String encryptStr = 'wqwdw3edq12wqdawqa'; // 加密字符串
  late String publicKeyStr = '';
  late String privateKeyStr = '';
  late RsaEncrypt userRSA = RsaEncrypt.initKey("", "");
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
  ModifyWebSiteList(List<WebSite> value){
    _webSiteList = value;
    notifyListeners();
  }

  Future<bool> initAppConfig() async {
    // await initDatabaseData();
    _webSiteList =
        await WebSite().select(getIsDeleted: false).orderBy('id').toList();
    if (publicKeyStr == '') {
      publicKeyStr = await getSysConfig('publicKeyStr');
    }
    if (privateKeyStr == '') {
      privateKeyStr = await getSysConfig('privateKeyStr');
    }
    userRSA = RsaEncrypt.initKey(publicKeyStr, privateKeyStr);
    return true;
  }

  setWebConfig(int userId,String webPubKey,String encryptStr){
    this.userId=userId;
    this.webPubKey=webPubKey;
    this.encryptStr=encryptStr;
  }

  clearUserInfo(){
    userId = -1;
    encryptStr='';
    notifyListeners();
  }
}

GlobalParams globalParams = GlobalParams();
