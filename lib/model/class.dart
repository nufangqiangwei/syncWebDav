import 'package:sync_webdav/model/model.dart';
import 'package:sync_webdav/model/JsonModel.dart';

class PassWordPageDetailData {
  PassWordPageDetailData() {
    webSite = WebSite();
    webSiteData = Password();
    data = PassWordData('', '');
    mark = [];
  }

  late WebSite webSite;
  late Password webSiteData;
  late int selectIndex = -1;
  late PassWordData data;
  late List<AccountMark> mark;
}
