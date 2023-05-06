import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sync_webdav/common/staticVariable.dart';
// import '../pkg/save/client.dart';
// import '../pkg/save/model.dart';
import '../utils/rsaUtils.dart';
import '../model/dbModel.dart';

class GlobalParams extends ChangeNotifier {
  final Map<String, List<VoidCallback>> _fieldCallback = {};
  late SysConfig _sysConfig;

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
  late String dbPath='';
  // webSite params
  late List<WebSite> _webSiteList = [];
  late double windowsWith = 0;
  late double windowsHeight = 0;

  List<WebSite> get webSiteList => _webSiteList;

  Future<bool> initAppConfig() async {
    // Store();
    sleep(const Duration(seconds: 1));
    // await getCachePath();
    await getUserInfo();
    await refreshWebSiteList();
    await loadRsaClient();
    return true;
  }

  // 保证在最开始启动程序的时候就初始化缓存文件地址，后续初始化orm的时候需要指定这个文件地址使用。
  getCachePath() async {
    if (kIsWeb) {
      throw ("未知的web平台");
    } else if (Platform.isAndroid){
      cachePath = (await getTemporaryDirectory()).path+"/myAggregationApp";
      dbPath = (await getApplicationSupportDirectory()).path;
    }else if (Platform.isWindows || Platform.isLinux ) {
      cachePath = (await getApplicationDocumentsDirectory()).path+"/myAggregationApp";
      dbPath = (await getApplicationSupportDirectory()).path;
    } else if (Platform.isIOS || Platform.isMacOS) {
      cachePath = (await getTemporaryDirectory()).path+"/myAggregationApp";
      dbPath = (await getLibraryDirectory()).path;
    } else if (Platform.isFuchsia) {
      throw ("未知的平台");
    }
    Directory directory = Directory(cachePath);
    if(!await directory.exists()){
      await directory.create();
    }
    print("缓存文件地址：$cachePath ， 数据库文件储存地址：$dbPath");
  }

  staticWebSiteData(){
    for (var i in InitWebData){
      _webSiteList.add(
          WebSite()
            ..icon=i['icon']??""
            ..url=i['url']??""
            ..webKey=i['webKey']??""
            ..name=i['name']??""
      );
    }
  }

  refreshWebSiteList() async {
    List<WebSite?> queryData = await DB.getInstance().orm.webSites.where().findAll();
    if (queryData.isNotEmpty && queryData is List<WebSite>) {
      _webSiteList = queryData;
    }else{
      staticWebSiteData();
    }
  }

  getUserInfo() async {
    // SysConfig config =
    //     await Store().from(SysConfigModel()).getModel() as SysConfig;
    SysConfig? config = await  DB.getInstance().orm.sysConfigs.get(1);
    if (config == null) {
      await DB.getInstance().orm.writeTxn(() async {
        _sysConfig = SysConfig();
        _sysConfig.userId=-1;
        _sysConfig.id =
        await DB.getInstance().orm.sysConfigs.put(_sysConfig);
      });

    }else{
      _sysConfig = config;
    }

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
    await DB.getInstance().orm.writeTxn(() async {
      await DB.getInstance().orm.sysConfigs.put(_sysConfig);
    });

  }

  setWebInfo(int passwordVersion) async {
    _sysConfig.passwordVersion = passwordVersion;
    await DB.getInstance().orm.writeTxn(() async {
      await DB.getInstance().orm.sysConfigs.put(_sysConfig);
    });
    //////////////////////////////
    this.passwordVersion = passwordVersion;
  }

  setUserRsaKey(String pubKey, String priKey)async {
    _sysConfig.userRsaPub = pubKey;
    _sysConfig.userRsaPri = priKey;
    await DB.getInstance().orm.writeTxn(() async {
      await DB.getInstance().orm.sysConfigs.put(_sysConfig);
    });
  }

  clearUserInfo() async{
    _sysConfig.userId = -1;
    await DB.getInstance().orm.writeTxn(() async {
      await DB.getInstance().orm.sysConfigs.put(_sysConfig);
    });
  }

  listingFieldModify(String fieldName, VoidCallback callback) {
    if (!_fieldCallback.containsKey(fieldName)) {
      _fieldCallback[fieldName] = [];
    }
    _fieldCallback[fieldName]?.add(callback);
  }
}

GlobalParams globalParams = GlobalParams();
