import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:sync_webdav/utils/log.dart';
import 'package:sync_webdav/utils/route.dart';

import 'common/Global.dart';
import 'model/model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initLog();
  await  initDatabase();
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
      title: 'Flutter Demo',
      initialRoute: "/index",
      routes:myRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
    );
  }
}