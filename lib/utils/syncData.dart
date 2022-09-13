import 'package:sync_webdav/Net/myServer.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/model/JsonModel.dart';
import 'package:sync_webdav/model/model.dart';

// 同步到最新版本的数据
Future<bool> syncPasswordVersion() async {
  var response = await getDataVersion();
  if (!response.containsKey("data")) {
    return false;
  }
  List<int> version = response["data"] ?? [];
  if (globalParams.passwordVersion == version.last) return true;
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
      Password DBData =
          await Password().select().webKey.equals(webKey).toSingleOrDefault();
      DBData.value = webData;
      DBData.save();
    }
  }
  return true;
}

// 同步到最新版本的数据
syncNoteBookVersion() async {
  var response = await getDataVersion();
  if (!response.containsKey("data")) {
    return;
  }
  List<int> version = response["data"] ?? [];
  if (globalParams.passwordVersion == version.last) return;
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
      Password DBData =
          await Password().select().webKey.equals(webKey).toSingleOrDefault();
      DBData.value = webData;
      DBData.save();
    }
  }
}

mergeData(List<PassWordData> oldData, List<PassWordData> newData) {
  List<PassWordData> oldData1 = oldData;
  List<PassWordData> newData1 = newData;
  List<PassWordData> result = [];
  for (var i in oldData) {
    PassWordData xx = newData.firstWhere((e) => e.userName == i.userName,
        orElse: () => PassWordData("", ""));
    if (xx.userName == "") {
      oldData1.removeWhere((e) => e.userName == i.userName);
      continue;
    }
    result.add(xx);
  }
}
