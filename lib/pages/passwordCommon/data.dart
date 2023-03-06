import 'package:sync_webdav/model/JsonModel.dart';

import '../../pkg/save/client.dart';
import '../../pkg/save/model.dart';

class WebSiteAccountData {
  WebSiteAccountData() {}

  late WebSite webSite= WebSite.fromMap({});
  late PassWord webSiteData= PassWord.fromMap({});
  late int selectIndex = -1;
  late List<AccountData> decodeData=[];
  late AccountData selectAccount= AccountData('','');

}