import 'package:sync_webdav/common/staticVariable.dart';
import 'package:sync_webdav/model/model.dart';

Future<String> getSysConfig(String key, {String? defaultValue}) async {
  defaultValue = defaultValue ?? '';
  var result = await SysConfig()
      .select()
      .where('key="$key"')
      .top(1)
      .toSingle();
  return result==null ? defaultValue:result.value!;
}

Future<String> getWebSiteData(String webSiteName) async {
  return (await Password()
      .select()
      .webKey
      .equals(webSiteName)
      .toSingleOrDefault())
      .value!;
}

List<WebSite> initDatabaseData() {
  print("下拉刷新");
  List<WebSite> webSiteList = [];
  for (var i = 0; i < InitWebData.length; i++) {
    if (i==10){
      break;
    }
    Map<String, String> x = InitWebData[i];
    webSiteList
        .add(WebSite(icon: x['url'], name: x['name'], webKey: x['webKey'],url: x['url']));
  }
  return webSiteList;
  // if (webSiteList.isNotEmpty){
  //   await WebSite().upsertAll(webSiteList);
  // }
  // await SysConfig(key:"publicKeyStr",value:"ajhwdsiefils").save();
  // await SysConfig(key:"privateKeyStr",value:"werfgwsegedrf").save();
}



