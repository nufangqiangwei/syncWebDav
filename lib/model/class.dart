import 'package:sync_webdav/model/model.dart';
import 'package:sync_webdav/model/JsonModel.dart';

class WebSiteAccountData {
  WebSiteAccountData() {
    webSite = WebSite();
    webSiteData = Password();
    selectAccount = AccountData('','');
    decodeData = [];

  }

  late WebSite webSite;
  late Password webSiteData;
  late int selectIndex = -1;
  late List<AccountData> decodeData;
  late AccountData selectAccount;

}
