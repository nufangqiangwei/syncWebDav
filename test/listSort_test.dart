import 'package:sync_webdav/model/model.dart';

void main() {
  List<WebSite> webSiteList = [
    WebSite(webKey:"tx"),
    WebSite(webKey:"alibaba"),
    WebSite(webKey:"github"),
    WebSite(webKey:"google"),
    WebSite(webKey:"huawei"),
  ];
  // List<String> webSiteList = [
  //   "tx",
  //   "alibaba",
  //   "github",
  //   "google",
  //   "huawei",
  // ];
  webSiteList.sort((a, b) => (a.webKey??"").compareTo(b.webKey??""));
  print(webSiteList);
}
