import 'package:flutter/material.dart';
import 'package:sync_webdav/pages/NoteBook.dart';
import 'package:sync_webdav/pages/home.dart';
import 'package:sync_webdav/pages/index.dart';
// import 'package:sync_webdav/pages/password.dart';
import 'package:sync_webdav/pages/newPasswordPage.dart';
import 'package:sync_webdav/pages/setting.dart';


 Map<String, WidgetBuilder> myRoute = {
   '/home': (BuildContext context) => const MyHomePage(),
   '/index': (BuildContext context) => const IndexPage(),
   '/password': (BuildContext context) => const PassWordPage(),
   '/setting': (BuildContext context) => const SettingPage(),
   '/userSetting': (BuildContext context) => const UserSettingPage(),
   '/webSetting': (BuildContext context) => const DatabaseSettingPage(),
   '/notebook': (BuildContext context) => const NotebookListPage(),
};