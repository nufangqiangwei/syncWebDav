import 'package:flutter/material.dart';

import 'drawer.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("主页"),
      ),
      drawer: const MyDrawer(),
      body: Image.asset('assets/images/index.jpg'),
    );
  }
}
