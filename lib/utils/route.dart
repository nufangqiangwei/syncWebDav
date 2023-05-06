import 'package:flutter/material.dart';
import 'package:sync_webdav/pages/newPasswordPage.dart';
import 'package:sync_webdav/pages/setting.dart';

import '../pages/passwordCommon/passwordWebListPage.dart';


 Map<String, WidgetBuilder> myRoute = {
   // '/home': (BuildContext context) => const MyHomePage(),
   // '/index': (BuildContext context) => const PassWordPage(),
   '/password': (BuildContext context) => const PassWordPage(),
   '/setting': (BuildContext context) => const SettingPage(),
   '/userSetting': (BuildContext context) => const UserSettingPage(),
   '/webSetting': (BuildContext context) => const DatabaseSettingPage(),
   '/test': (BuildContext context) => const AddWebSitePage(),
};