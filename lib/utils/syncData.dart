import 'package:isar/isar.dart';
import 'package:sync_webdav/Net/myServer.dart';
import '../common/passwordUtils.dart';
import '../model/JsonModel.dart';

// import '../pkg/save/model.dart';
// import '../pkg/save/client.dart';
import '../model/dbModel.dart';

// 同步到最新版本的数据
Future<bool> syncPasswordVersion() async {
  List<ServerGetPasswordDataResponse> response = [];
  try {
    response = await getPasswordData();
  } catch (e) {
    return false;
  }
  List<PassWord?> queryData =
      await DB.getInstance().orm.passWords.where().findAll();
  Map<String, PassWord> localData = {};
  for (var item in queryData) {
    item as PassWord;
    localData[item.webKey] = item;
  }
  List<PassWord> insertData = [];
  List<PassWord> updateData = [];
  List<Map<String, String>> updateWeb = []; // 需要上传到服务器的数据
  for (var remoteWebSite in response) {
    PassWord? localValue = localData.remove(remoteWebSite.webKey);
    if (localValue != null) {
      // 更新
      if (await _checkRemoteData(localValue, remoteWebSite.webData)) {
        updateWeb
            .add({"webKey": localValue.webKey, "fromData": localValue.value});
      }
      updateData.add(localValue);
    } else {
      PassWord a = PassWord()
        ..webKey = remoteWebSite.webKey
        ..value = remoteWebSite.webData
        ..isModify = false
        ..isEncryption = true;
      insertData.add(a);
    }
  }

  if (insertData.isNotEmpty) {
    await DB.getInstance().orm.writeTxn(() async {
      await DB.getInstance().orm.passWords.putAll(insertData);
    });
  }
  if (updateData.isNotEmpty) {
    await DB.getInstance().orm.writeTxn(() async {
      await DB.getInstance().orm.passWords.putAll(updateData);
    });
  }
  if (updateWeb.isNotEmpty) {
    // 上传本地比线上还新的数据
    await pushDataToServer(updateWeb, 'password');
  }
  return true;
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

// 对比账号最后修改时间，本地数据可能比线上新
Future<bool> _checkRemoteData(PassWord local, String remote) async {
  List<AccountData> localPassword = await decodePassword(local);
  PassWord remoteData = PassWord()
  ..value=remote
  ..isEncryption=true;
  List<AccountData> remotePassword = await decodePassword(remoteData);
  List<AccountData> mergeAccountList = [];
  bool mustUpdateRemote = false;
  Map<String, AccountData> localPasswordDict = {};
  Map<String, AccountData> remotePasswordDict = {};
  for (var i in localPassword) {
    localPasswordDict[i.userName] = i;
  }
  for (var i in remotePassword) {
    remotePasswordDict[i.userName] = i;
  }
  for (var i in localPasswordDict.entries) {
    String userName = i.key;
    AccountData localValue = i.value;
    AccountData? remoteValue = remotePasswordDict.remove(userName);
    if (remoteValue != null) {
      if (localValue.lastModifyTime > remoteValue.lastModifyTime) {
        // 本地数据比线上数据新，需要上传到线上
        mergeAccountList.add(localValue);
        mustUpdateRemote = true;
      } else if (localValue.lastModifyTime <= remoteValue.lastModifyTime) {
        // 线上数据比本地新，保存为线上的数据
        mergeAccountList.add(remoteValue);
      }
    } else {
      // 线上不存在的账号，不做修改
      mergeAccountList.add(localValue);
    }
  }
  await encodePassword(local, mergeAccountList);
  return mustUpdateRemote;
}
