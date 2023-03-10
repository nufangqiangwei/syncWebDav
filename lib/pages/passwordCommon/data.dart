import 'package:flutter/cupertino.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/model/JsonModel.dart';

import '../../common/passwordUtils.dart';
import '../../pkg/save/client.dart';
import '../../pkg/save/model.dart';
import '../../utils/modifyData.dart';

class _WebSiteAccountData {
  _WebSiteAccountData();

  late WebSite selectWebSite= WebSite.fromMap({});
  late PassWord webSiteData= PassWord.fromMap({});
  late int selectIndex = -1;
  late List<AccountData> decodeData=[];
  late AccountData accountData = AccountData('', '');
  late AccountData unmodifiedAccountData = AccountData('', '');
}

class PassWordDataController{
  static final _WebSiteAccountData _data = _WebSiteAccountData();
  static final ValueNotifier<bool> _webSiteModifyCallback = ValueNotifier<bool>(false);
  static final ValueNotifier<bool> _accountModifyCallback = ValueNotifier<bool>(false);
  static final ValueNotifier<String> pageChange = ValueNotifier<String>('webSite');

  static String get pageName => pageChange.value;
  static blackPage([String? value]) {
    if (value != null) {
      pageChange.value=value;
      return false;
    }
    switch (pageChange.value) {
      case 'webSite':
        {
          return true;
        }
      case 'account':
        {
          pageChange.value = 'webSite';
          return false;
        }
      case 'detail':
        {
          pageChange.value = 'account';
          return false;
        }
      default:
        {
          return false;
        }
    }


  }
  static List<WebSite>  get webSiteList => globalParams.webSiteList;
  static WebSite get selectWebSite => _data.selectWebSite;
  static List<AccountData> get webSiteAccount => _data.decodeData;
  static AccountData get selectAccountData =>_data.accountData;

  static set setSelectAccountUserName(String userName){
    // 用户名禁止修改，只有新建账号的时候才能修改用户名。
    if(_data.unmodifiedAccountData.userName == ''){
      _data.accountData.userName = userName;
    }
  }
  static set setSelectAccountPassword(String password){
    _data.accountData.password = password;
  }
  // 选择站点触发的事件
  static listenerWebSiteChange(VoidCallback callback){
    _webSiteModifyCallback.addListener(callback);
  }
  static removeListenerWebSiteChange(VoidCallback callback){
    _webSiteModifyCallback.removeListener(callback);
  }
  // 选择账号触发的事件
  static listenerAccountChange(VoidCallback callback){
    _accountModifyCallback.addListener(callback);
  }
  static removeListenerAccountChange(VoidCallback callback){
    _accountModifyCallback.removeListener(callback);
  }

  static switchToWebSite(WebSite webSite) async{
    _data.webSiteData = await Store()
        .select([PassWordModel.webKey.equal(webSite.webKey)])
        .from(PassWordModel())
        .lastModel() as PassWord;
    if (_data.webSiteData.webKey == ''){
      _data.webSiteData.webKey = webSite.webKey;
    }
    _data.decodeData = await decodePassword(_data.webSiteData);
    _data.selectWebSite = webSite;
    selectAccount(0);
    _webSiteModifyCallback.value = !_webSiteModifyCallback.value;
  }

  static selectAccount(int index){
    if (index < 0){
      _data.accountData = AccountData('','');
      _data.unmodifiedAccountData = AccountData('','');
      index = -1;
    }
    if(_data.decodeData.length < index){
      throw ("错误的序号");
    }
    if(_data.decodeData.isNotEmpty && index >= 0){
      _data.accountData = _data.decodeData[index];
      _data.unmodifiedAccountData = AccountData(_data.accountData.userName,_data.accountData.password);
    }
    _data.selectIndex = index;
    _accountModifyCallback.value =!_accountModifyCallback.value;
  }

  static saveAccount()async{
    if(_data.accountData.userName == ''){
      return;
    }
    if(_data.accountData.password == _data.unmodifiedAccountData.password){
      print('未修改密码');
      return;
    }else{
      print('修改密码');
      _data.accountData.lastUsePassword += " ${_data.unmodifiedAccountData.password}";
      _data.accountData.lastModifyTime =  DateTime.now().millisecondsSinceEpoch;
    }

    if(_data.selectIndex<0){
      _data.decodeData.add(_data.accountData);
    }else if(_data.decodeData.isEmpty){
      _data.decodeData.add(_data.accountData);
    }else{
      _data.decodeData[_data.selectIndex] = _data.accountData;
    }

    _data.webSiteData.version = _data.webSiteData.version + 1;
    bool isNewData = _data.webSiteData.value == '';
    _data.webSiteData.isModify = true;
    PassWord encodeData = await encodePassword(_data.webSiteData, _data.decodeData);
    if (isNewData) {
      await Store().insert(modelData: encodeData);
      print("新增");
    } else {
      print("更新");
      await Store().update(modelData: encodeData);
    }
    _data.webSiteData = encodeData;
    // 上传到服务器
    uploadData("password");

    print("保存事件");
    _webSiteModifyCallback.value = !_webSiteModifyCallback.value;
    _accountModifyCallback.value =!_accountModifyCallback.value;

  }


}