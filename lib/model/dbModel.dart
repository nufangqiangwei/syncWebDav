import 'package:isar/isar.dart';
import 'package:sync_webdav/common/Global.dart';
part 'dbModel.g.dart';

@collection
class SysConfig {
  Id id = Isar.autoIncrement;
  late int userId=0;
  late String userRsaPri='';
  late String userRsaPub='';
  late String webRsaPub='';
  late String encryptStr='';
  late int passwordVersion=0;

}
@collection
class WebSite  {
  Id id = Isar.autoIncrement;
  late String icon='';
  late String name='';
  late String url='';
  late String webKey='';
  WebSite([this.icon='', this.name='', this.url='', this.webKey='']);
}

@collection
class PassWord  {
  Id id = Isar.autoIncrement;
  late String webKey='';
  late String value='';
  late int version=0;
  late bool isModify=false;
  late bool isEncryption=false;
  PassWord([this.webKey='', this.value='', this.version=0, this.isModify=false, this.isEncryption=false]);
}

class DB{
  late Isar _orm;
  late bool _init=false;
  static DB? _instance;
  DB._();

  static DB getInstance() {
    _instance ??= DB._();
    return _instance!;
  }
  openOrm()async{
    if (_init)return;
    _orm = await Isar.open([SysConfigSchema,WebSiteSchema,PassWordSchema], directory : globalParams.dbPath);
    _init = true;
  }
  Isar get orm => _orm;
}


t()async{
  SysConfig? config = await  DB.getInstance().orm.sysConfigs.get(0);
}