import 'package:sync_webdav/Net/myServer.dart';
import 'package:sync_webdav/common/Global.dart';
import '../pkg/save/model.dart';
import '../pkg/save/client.dart';

// 同步到最新版本的数据
Future<bool> syncPasswordVersion() async {
  List<int> version = await getDataVersion();
  if (version.isEmpty || globalParams.passwordVersion == version.last) return true;
  if (globalParams.passwordVersion < version.last) {
    List<Map<String, String>> data = [];
    try {
      data = await getPasswordData(version.last);
    } catch (e) {
      return false;
    }

    for (var i in data) {
      String webKey = i["webKey"] ?? "";
      String webData = i["webData"] ?? "";
      if (webKey == "") {
        print(data.toString());
        print("第 $i数据出错");
        continue;
      }
      Store().select([PassWordModel.webKey.equal(webKey)]).update(jsonData: {"value":webData});
    }
  }
  return true;
}

// 同步到最新版本的数据
syncNoteBookVersion() async {
  List<int> version = await getDataVersion();
  if (version.isEmpty || globalParams.passwordVersion == version.last) return;
  if (globalParams.passwordVersion < version.last) {
    List<Map<String, String>> data = await getPasswordData(version.last);
    for (var i in data) {
      String webKey = i["webKey"] ?? "";
      String webData = i["webData"] ?? "";
      if (webKey == "") {
        print(data.toString());
        print("第 $i数据出错");
        continue;
      }
      Store().from(NoteBookModel()).select([NoteBookModel.description.equal(webKey)]).update(jsonData: {"value":webData});
    }
  }
}

// mergeData(List<AccountData> oldData, List<AccountData> newData) {
//   List<AccountData> oldData1 = oldData;
//   List<AccountData> newData1 = newData;
//   List<AccountData> result = [];
//   for (var i in oldData) {
//     AccountData xx = newData.firstWhere((e) => e.userName == i.userName,
//         orElse: () => AccountData("", ""));
//     if (xx.userName == "") {
//       oldData1.removeWhere((e) => e.userName == i.userName);
//       continue;
//     }
//     result.add(xx);
//   }
// }
