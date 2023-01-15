import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_webdav/common/Global.dart';

import 'drawer.dart';
import 'index.dart';
// import 'newPasswordPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<GlobalParams>(context).appBarText),
      ),
      body: const IndexBody(),
      drawer: const MyDrawer(),
    );
  }
}
