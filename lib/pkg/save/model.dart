import 'client.dart';

abstract class DbValue {
  Map<String, dynamic> toMap();

  DbModel getModel();
}

abstract class DbModel {
  bool isOnly = false;
  String indexField = '';
  String tableName = "";

  DbValue fromMap(Map<String, dynamic>? mapData);
}

class SysConfig implements DbValue {
  late int userId;
  late String userRsaPri;
  late String userRsaPub;
  late String webRsaPub;
  late String encryptStr;
  late int passwordVersion;

  SysConfig.fromMap(Map<String, dynamic> mapData) {
    userId = mapData['userId'] ?? SysConfigModel.userId.defaultValue;
    userRsaPri =
        mapData['userRsaPri'] ?? SysConfigModel.userRsaPri.defaultValue;
    userRsaPub =
        mapData['userRsaPub'] ?? SysConfigModel.userRsaPub.defaultValue;
    webRsaPub = mapData['webRsaPub'] ?? SysConfigModel.webRsaPub.defaultValue;
    encryptStr =
        mapData['encryptStr'] ?? SysConfigModel.encryptStr.defaultValue;
    passwordVersion = mapData['passwordVersion'] ??
        SysConfigModel.passwordVersion.defaultValue;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "userRsaPri": userRsaPri,
      "userRsaPub": userRsaPub,
      "webRsaPub":webRsaPub,
      "encryptStr": encryptStr,
      "passwordVersion": passwordVersion,
    };
  }

  @override
  DbModel getModel() {
    return SysConfigModel();
  }
}

class SysConfigModel implements DbModel {
  static DbInt userId =
  DbInt(table: SysConfigModel(), field: "userId", defaultValue: -1);
  static DbString userRsaPri =
  DbString(table: SysConfigModel(), field: "userRsaPri");
  static DbString userRsaPub =
  DbString(table: SysConfigModel(), field: "userRsaPub");
  static DbString webRsaPub =
  DbString(table: SysConfigModel(), field: "webRsaPub");
  static DbString encryptStr =
  DbString(table: SysConfigModel(), field: "encryptStr");
  static DbInt passwordVersion =
  DbInt(table: SysConfigModel(), field: "passwordVersion");


  @override
  bool isOnly = true;
  @override
  String indexField = "userId";
  @override
  String tableName = "SysConfig";
  @override
  SysConfig fromMap(Map<String, dynamic>? mapData) {
    mapData ??= <String,dynamic>{};
    return SysConfig.fromMap(mapData);
  }


}

class WebSite extends DbValue {
  late String icon;
  late String name;
  late String url;
  late String webKey;

  WebSite({required this.icon,required this.name, required this.url,required this.webKey});
  WebSite.fromMap(Map<String, dynamic> mapData) {
    icon = mapData['icon'] ?? WebSiteModel.icon.defaultValue;
    name = mapData['name'] ?? WebSiteModel.name.defaultValue;
    url = mapData['url'] ?? WebSiteModel.url.defaultValue;
    webKey = mapData['webKey'] ?? WebSiteModel.webKey.defaultValue;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "icon": icon,
      "name": name,
      "url": url,
      "webKey": webKey,
    };
  }

  @override
  DbModel getModel() {
    return WebSiteModel();
  }
}

class WebSiteModel implements DbModel {
  static DbString icon = DbString(table: WebSiteModel(), field: "icon");
  static DbString name = DbString(table: WebSiteModel(), field: "name");
  static DbString url = DbString(table: WebSiteModel(), field: "url");
  static DbString webKey = DbString(table: WebSiteModel(), field: "webKey");

  @override
  bool isOnly = false;
  @override
  String indexField = "webKey";
  @override
  String tableName = "WebSite";
  @override
  WebSite fromMap(Map<String, dynamic>? mapData) {
    mapData ??= <String,dynamic>{};
    return WebSite.fromMap(mapData);
  }

}

class PassWord implements DbValue {
  late String webKey;
  late String value;
  late int version;
  late bool isModify;
  late bool isEncryption;

  PassWord.fromMap(Map<String, dynamic> mapData) {
    webKey = mapData['webKey'] ?? PassWordModel.webKey.defaultValue;
    value = mapData['value'] ?? PassWordModel.value.defaultValue;
    version = mapData['version'] ?? PassWordModel.version.defaultValue;
    isModify = mapData['isModify'] ?? PassWordModel.isModify.defaultValue;
    isEncryption =
        mapData['isEncryption'] ?? PassWordModel.isEncryption.defaultValue;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "webKey": webKey,
      "value": value,
      "version": version,
      "isModify": isModify,
      "isEncryption": isEncryption,
    };
  }

  @override
  DbModel getModel() {
    return PassWordModel();
  }
}

class PassWordModel implements DbModel {
  static DbString webKey = DbString(table: PassWordModel(), field: "webKey");
  static DbString value = DbString(table: PassWordModel(), field: "value");
  static DbInt version =
  DbInt(table: PassWordModel(), field: "version", defaultValue: 0);
  static DbBool isModify = DbBool(table: PassWordModel(), field: "isModify");
  static DbBool isEncryption =
  DbBool(table: PassWordModel(), field: "isEncryption");

  @override
  bool isOnly = false;
  @override
  String indexField = "webKey";
  @override
  String tableName = "PassWord";
  @override
  PassWord fromMap(Map<String, dynamic>? mapData) {
    mapData ??= <String,dynamic>{};
    return PassWord.fromMap(mapData);
  }
}

class NoteBook implements DbValue {
  late bool isImportant;
  late int number;
  late String title;
  late String description;
  late bool isEncryption;
  late bool isModify;

  NoteBook()
      : isImportant = NoteBookModel.isImportant.defaultValue,
        number = NoteBookModel.number.defaultValue,
        title = NoteBookModel.title.defaultValue,
        description = NoteBookModel.description.defaultValue,
        isEncryption = NoteBookModel.isEncryption.defaultValue,
        isModify = NoteBookModel.isModify.defaultValue;

  NoteBook.fromMap(Map<String, dynamic> mapData) {
    isImportant =
        mapData['isImportant'] ?? NoteBookModel.isImportant.defaultValue;
    number = mapData['number'] ?? NoteBookModel.number.defaultValue;
    title = mapData['title'] ?? NoteBookModel.title.defaultValue;
    description =
        mapData['description'] ?? NoteBookModel.description.defaultValue;
    isEncryption =
        mapData['isEncryption'] ?? NoteBookModel.isEncryption.defaultValue;
    isModify = mapData['isModify'] ?? NoteBookModel.isModify.defaultValue;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "isImportant": isImportant,
      "number": number,
      "title": title,
      "description": description,
      "isEncryption": isEncryption,
      "isModify": isModify,
    };
  }

  @override
  DbModel getModel() {
    return NoteBookModel();
  }
}

class NoteBookModel implements DbModel {
  static DbBool isImportant =
  DbBool(table: NoteBookModel(), field: "isImportant");
  static DbInt number = DbInt(table: NoteBookModel(), field: "number");
  static DbString title = DbString(table: NoteBookModel(), field: "title");
  static DbString description =
  DbString(table: NoteBookModel(), field: "description");
  static DbBool isEncryption =
  DbBool(table: NoteBookModel(), field: "isEncryption");
  static DbBool isModify = DbBool(table: NoteBookModel(), field: "isModify");

  @override
  bool isOnly = false;
  @override
  String indexField = "number";
  @override
  String tableName = "NoteBook";
  @override
  NoteBook fromMap(Map<String, dynamic>? mapData) {
    mapData ??= <String,dynamic>{};
    return NoteBook.fromMap(mapData);
  }
}
