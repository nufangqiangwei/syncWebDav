import 'package:flutter/material.dart';

import 'drawer.dart';
import 'index.dart';
// import 'newPasswordPage.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  Widget mobilePage(){
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

  @override
  Widget build(BuildContext context) {

    return mobilePage();
  }
}


class BigScreenPage extends StatefulWidget{
  const BigScreenPage({Key? key}) : super(key: key);

  @override
  State<BigScreenPage> createState() =>_BigScreenPage();

}
class _BigScreenPage extends State<BigScreenPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
