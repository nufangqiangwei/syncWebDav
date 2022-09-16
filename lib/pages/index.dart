import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:path/path.dart' as path;
import 'drawer.dart';
import 'package:logger/src/outputs/file_output.dart';
import 'dart:developer' as developer;

Logger? log;

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

class IndexBody extends StatelessWidget {
  const IndexBody({Key? key}) : super(key: key);

  initLogServer() async {
    Map<String, dynamic> map = {};
    map['msg'] = 'e.toString()';
    Dio().post('http://192.168.1.21:5000/error', data: map);
    try {
      Directory cachePath = await getTemporaryDirectory();
      log = Logger(
        output: FileOutput(file: File(path.join(cachePath.path, "app.log"))),
      );
      developer.log('log me', name: 'my.app.category');
    } catch (e) {
      Map<String, dynamic> map = {};
      map['msg'] = e.toString();
      Dio().post('http://192.168.1.21:5000/error', data: map);
    }
  }

  initDatabaseServer() async {
    try {
      await globalParams.initAppConfig();
    } catch (e) {
      log!.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(onPressed: initLogServer, child: const Text("初始化日志")),
        TextButton(onPressed: initDatabaseServer, child: const Text("初始化数据库"))
      ],
    );
  }
}
