import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_webdav/pages/home.dart';

import 'common/Global.dart';
import 'common/utils.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await globalParams.initPasswordData();
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
    // final size = MediaQuery.of(context).size;
    //  globalParams.windowsWith = size.width;
    //  globalParams.windowsHeight = size.height;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}