import 'package:sync_webdav/model/JsonModel.dart';

import '../pkg/save/model.dart';

class WebSiteAccountData {
  WebSiteAccountData() {
    webSite = WebSite.fromMap({});
    webSiteData = PassWord.fromMap({});
    selectAccount = AccountData('','');
    decodeData = [];

  }

  late WebSite webSite;
  late PassWord webSiteData;
  late int selectIndex = -1;
  late List<AccountData> decodeData;
  late AccountData selectAccount;

}
