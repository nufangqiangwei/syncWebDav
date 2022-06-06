import 'package:flutter/material.dart';
import 'package:sync_webdav/common/staticVariable.dart';
import 'package:sync_webdav/common/utils.dart';
import '../model/model.dart';

class GlobalParams extends ChangeNotifier {
  String _appBarText = 'Flutter Demo Home Page';
  static String publicKeyStr = '';
  static String privateKeyStr = '';
  late List<WebSite> _webSiteList = [];
  late String _page = 'webSite';
  late double windowsWith = 0;
  late double windowsHeight = 0;

  String get appBarText => _appBarText;
  // ignore: non_constant_identifier_names
  ModifyAppBarText(String value) {
    _appBarText = value;
    notifyListeners();
  }
  String get page => _page;
  // ignore: non_constant_identifier_names
  ModifyPage(String value){
    _page = value;
    notifyListeners();
  }

  List<WebSite> get webSiteList => _webSiteList;
  // ignore: non_constant_identifier_names
  ModifyWebSiteList(List<WebSite> value){
    _webSiteList = value;
    notifyListeners();
  }

  Future<String> initPasswordData() async {
    // await initDatabaseData();
    var list =
        await WebSite().select(getIsDeleted: false).orderBy('id').toList();
    if (GlobalParams.publicKeyStr == '') {
      GlobalParams.publicKeyStr = await getSysConfig('publicKeyStr');
    }
    if (GlobalParams.privateKeyStr == '') {
      GlobalParams.privateKeyStr = await getSysConfig('privateKeyStr');
    }
    ModifyWebSiteList(list);
    return '';
  }
}

GlobalParams globalParams = GlobalParams();
/*
* import 'package:flutter/material.dart';
import 'package:sync_webdav/common/staticVariable.dart';
import 'package:sync_webdav/common/utils.dart';
import '../model/model.dart';

class GlobalParams {
  static Map<String, List<Function()>> _eventCall = {};
  static String _appBarText = 'Flutter Demo Home Page';
  static List<WebSite> _webSiteList = [];
  static String _page = 'webSite';
  static String publicKeyStr = '';
  static String privateKeyStr = '';

  String get appBarText => _appBarText;

  set appBarText(String value) {
    _appBarText = value;
    _call('appBarText');
  }

  String get page => _page;

  set page(String value) {
    _page = value;
    _call('page');
  }

  List<WebSite> get webSiteList => _webSiteList;

  set webSiteList(List<WebSite> value) {
    _webSiteList = value;
    _call('webSiteList');
  }

  static registerEvent(String eventName, Function() callBack) {
    if (_eventCall[eventName] == null) {
      _eventCall[eventName] = [callBack];
      return;
    }
    _eventCall[eventName]?.add(callBack);
  }

  static _call(String eventName){
    List<Function()>? callBackList = _eventCall[eventName];
    if (callBackList != null) {
      for (var i = 0; i < callBackList.length; i++) {
        callBackList[i]();
      }
    }
  }

}

Future<String> initPasswordData() async {
  // await initDatabaseData();
  GlobalParams.webSiteList = await WebSite().select(getIsDeleted: false).orderBy('id').toList();
  if (GlobalParams.publicKeyStr == '') {
    GlobalParams.publicKeyStr = await getSysConfig('publicKeyStr');
  }
  if (GlobalParams.privateKeyStr == '') {
    GlobalParams.privateKeyStr = await getSysConfig('privateKeyStr');
  }
  return '';
}

* */
