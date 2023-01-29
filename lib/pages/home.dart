import 'package:flutter/material.dart';

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
      extendBodyBehindAppBar:true,
      appBar: AppBar(
        title: const Text("首页"),
        backgroundColor: const Color(0x44000000),
        elevation: 0,
      ),
      body: const ShowRandomImagePage(),
      drawer: const MyDrawer(),
    );
  }
}
