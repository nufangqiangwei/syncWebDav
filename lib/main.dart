import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:sync_webdav/pkg/save/client.dart';
import 'package:sync_webdav/utils/log.dart';
import 'package:sync_webdav/utils/route.dart';

import 'common/Global.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initLog();
  // await  initDatabase();
  await DB.getInstance().init();
  await globalParams.initAppConfig();
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