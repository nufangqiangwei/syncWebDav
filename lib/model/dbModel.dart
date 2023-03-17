import 'package:isar/isar.dart';
part 'dbModel.g.dart';

@collection
class SysConfig {
  Id id = Isar.autoIncrement;
  late int userId;
  late String userRsaPri;
  late String userRsaPub;
  late String webRsaPub;
  late String encryptStr;
  late int passwordVersion;

}
@collection
class WebSite  {
  Id id = Isar.autoIncrement;
  late String icon;
  late String name;
  late String url;
  late String webKey;
}

@collection
class PassWord  {
  Id id = Isar.autoIncrement;
  late String webKey;
  late String value;
  late int version;
  late bool isModify;
  late bool isEncryption;
}

class DB{
  late Isar _orm;

  static DB? _instance;
  DB._(){
    Isar.open([SysConfigSchema,WebSiteSchema,PassWordSchema]).then((value) => _orm=value);
  }

  static DB getInstance() {
    _instance ??= DB._();
    return _instance!;
  }

  Isar get orm => _orm;
}


t()async{
  SysConfig? config = await  DB.getInstance().orm.sysConfigs.get(0);
}