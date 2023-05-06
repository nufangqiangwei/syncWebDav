import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
// import 'package:sync_webdav/utils/log.dart';
import 'package:sync_webdav/utils/route.dart';

import 'common/Global.dart';
// import 'model/dbModel.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await initLog();
  // await  initDatabase();
  // await globalParams.getCachePath();
  // await DB.getInstance().openOrm();
  // await globalParams.initAppConfig();
  globalParams.staticWebSiteData();

  // HttpOverrides.global=GlobalHttpOverrides();

  runApp(
    MultiProvider(
        providers:[
          ChangeNotifierProvider<GlobalParams>.value(value: globalParams)
        ],
      child: const MyApp(),
    )
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: "/password",
      routes:myRoute,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
    );
  }
}
// class GlobalHttpOverrides extends HttpOverrides {
//
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     // TODO: implement createHttpClient
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }