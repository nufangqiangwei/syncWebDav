import 'package:isar/isar.dart';
import 'package:sync_webdav/Net/myServer.dart';
import 'package:sync_webdav/common/Global.dart';
// import '../pkg/save/client.dart';
// import '../pkg/save/model.dart';
import '../../utils/log.dart';
import '../model/dbModel.dart';
Future<String?> uploadData(String tableName) async {
  if (globalParams.userId == -1) {
    return null;
  }
  try {
    List<dynamic> data;
    if (tableName == "password") {
      data = await uploadPasswordData();
    } else if (tableName == "notebook") {
      data = [];
    } else {
      throw "错误的表名 $tableName";
    }
    await pushDataToServer(data, tableName);
    if (tableName == "password") {
      List<PassWord?> q = await DB.getInstance().orm.passWords.filter().isModifyEqualTo(true).findAll();
      List<PassWord> saveData = [];
      for(var i in q){
        if (i != null){
          i.isModify = false;
          saveData.add(i);
        }
      }
      await DB.getInstance().orm.writeTxn(() async {
        await DB.getInstance().orm.passWords.putAll(saveData);
      });

    } else {
    }
  } catch (e, tr) {
    log!.e("上传备份到服务器出错: ");
  }

  return null;
}

Future<List<Map<String, String>>> uploadPasswordData() async {
  List<PassWord?> query = await DB.getInstance().orm.passWords.filter().isModifyEqualTo(true).findAll();

  // 显示转换列表数据类型
  List<PassWord> queryData = List<PassWord>.from(query);
  List<Map<String, String>> data = [];
  Map<String, int> cache = {};
  Map<String, String> result = {};
  for (final i in queryData) {
    if (cache[i.webKey] == null) {
      result[i.webKey] = i.value;
      cache[i.webKey] = i.version;
    } else if (cache[i.webKey]! < i.version) {
      result[i.webKey] = i.value;
    }
  }
  for (final webKey in result.keys) {
    data.add({"DataKey": webKey, "Value": result[webKey] ?? ''});
  }
  return data;
}

downloadData() {
  if (globalParams.userId == -1) {
    return null;
  }
}
