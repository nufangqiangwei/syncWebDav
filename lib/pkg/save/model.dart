import 'client.dart';

class UserModel {
  static bool isOnly = true;
  static DbString userId = DbString(table: "User", field: "userId", defaultValue: "11");
}

class SysConfigModel{
  static bool isOnly = true;
}

class WebSiteModel{
  static DbString icon = DbString(table: "WebSite", field: "icon");
  static DbString name = DbString(table: "WebSite", field: "name");
  static DbString url = DbString(table: "WebSite", field: "url");
  static DbString webKey  = DbString(table: "WebSite", field: "webKey");
}

class PassWordModel{
  static DbString webKey = DbString(table: "PassWord", field: "webKey");
  static DbString value = DbString(table: "PassWord", field: "value");
  static DbInt version = DbInt(table: "PassWord", field: "value");
  static DbBool isModify = DbBool(table: "PassWord", field: "value");
  static DbBool isEncryption = DbBool(table: "PassWord", field: "value");
}


class NoteBookModel{
  static DbBool isImportant = DbBool(table: "NoteBook", field: "isImportant");
  static DbInt number = DbInt(table: "NoteBook", field: "number");
  static DbString title = DbString(table: "NoteBook", field: "title");
  static DbString description = DbString(table: "NoteBook", field: "description");
  static DbBool isEncryption = DbBool(table: "NoteBook", field: "value");
}
