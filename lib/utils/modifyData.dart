import 'package:sync_webdav/Net/myServer.dart';
import 'package:sync_webdav/common/Global.dart';
import '../pkg/save/client.dart';
import '../pkg/save/model.dart';

Future<String?> uploadData(String tableName) async {
  if (globalParams.userId == -1) {
    return null;
  }

  List<dynamic> data;
  if (tableName == "password") {
    data = await uploadPasswordData();
  } else if (tableName == "notebook") {
    data = await Store().select([NoteBookModel.isModify.equal(true)]).all();
  } else {
    throw "错误的表名 $tableName";
  }
  try {
    await pushDataToServer(data, tableName);
  } catch (e,tr) {
    print(tr);
    return "网络请求错误";
  }
  if (tableName == "password") {
    await Store().select([PassWordModel.isModify.equal(true)]).update(jsonData: {"isModify": false});
  } else {
    await Store().select([NoteBookModel.isModify.equal(true)]).update(jsonData: {"isModify": false});
  }
  return null;
}

Future<List<Map<String,String>>> uploadPasswordData() async{
  List<DbValue> query = await Store().select([PassWordModel.isModify.equal(true)]).all();
  List<Map<String,String>> data=[];
  Map<String,int> cache={};
  Map<String,String> result= {};
  for (final i in query) {
    if (i is PassWord){
      if(cache[i.webKey]==null){
        result[i.webKey]=i.value;
        cache[i.webKey]=i.version;
      }else if(cache[i.webKey]!<i.version){
        result[i.webKey]=i.value;
      }
    }
  }
  for(final webKey in result.keys){
    data.add({
      "webKey":webKey,
      "fromData":result[webKey]??''
    });
  }


  return data;
}


downloadData(){
  if (globalParams.userId == -1) {
    return null;
  }

}
