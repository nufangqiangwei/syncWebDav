import 'package:sync_webdav/model/model.dart';
import 'package:sync_webdav/model/JsonModel.dart';

class PassWordPageDetailData {
  PassWordPageDetailData() {
    webSite = WebSite();
    data = PassWordData('', '');
    mark = [];
  }

  late WebSite webSite;
  late int selectIndex = -1;
  late PassWordData data;
  late List<AccountMark> mark;
}
