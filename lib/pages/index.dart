import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'drawer.dart';
import 'package:path_provider/path_provider.dart';

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
      body: const IndexBody(),
    );
  }
}

class IndexBody extends StatefulWidget {
  const IndexBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IndexBodyState();
}

class _IndexBodyState extends State<IndexBody> {
  String getTemporaryDirectoryPath = '';
  String getApplicationSupportDirectoryPath = '';
  String getApplicationDocumentsDirectoryPath = '';
  String getExternalStorageDirectoryPath = '';
  List<String> getExternalCacheDirectoriesPath = [];
  List<String> getExternalStorageDirectoriesPath = [];
  String downloadsDirectoryPath = '';

  selectPath() async {
    getTemporaryDirectoryPath = (await getTemporaryDirectory()).path;
    getApplicationSupportDirectoryPath =
        (await getApplicationSupportDirectory()).path;
    getApplicationDocumentsDirectoryPath =
        (await getApplicationDocumentsDirectory()).path;
    var x = await getExternalStorageDirectory();
    getExternalStorageDirectoryPath = x == null ? "无目录" : x.path;

    var y = await getExternalCacheDirectories();
    getExternalCacheDirectoriesPath = [];
    if (y != null) {
      for (final p in y) {
        getExternalCacheDirectoriesPath.add(p.path);
      }
    } else {
      getExternalCacheDirectoriesPath.add("无目录");
    }

    var z = await getExternalStorageDirectories();
    getExternalStorageDirectoriesPath = [];
    if (z != null) {
      for (final p in z) {
        getExternalStorageDirectoriesPath.add(p.path);
      }
    } else {
      getExternalStorageDirectoriesPath.add("无目录");
    }

    setState(() {});
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  TextStyle titleStyle() {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(onPressed: selectPath, child: const Text("获取路径")),
        Text(
          "getTemporaryDirectory",
          style: titleStyle(),
        ),
        Text(getTemporaryDirectoryPath),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
        Text(
          "getApplicationSupportDirectory",
          style: titleStyle(),
        ),
        Text(getApplicationSupportDirectoryPath),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
        Text(
          "getApplicationDocumentsDirectory",
          style: titleStyle(),
        ),
        Text(getApplicationDocumentsDirectoryPath),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
        Text(
          "getExternalStorageDirectory",
          style: titleStyle(),
        ),
        Text(getExternalStorageDirectoryPath),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
        Text(
          "getExternalCacheDirectories",
          style: titleStyle(),
        ),
        SizedBox(
          height: (getExternalCacheDirectoriesPath.length + 1) * 20,
          child: ListView.builder(
              itemCount: getExternalCacheDirectoriesPath.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(getExternalCacheDirectoriesPath[index]);
              }),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
        Text(
          "getExternalStorageDirectories",
          style: titleStyle(),
        ),
        SizedBox(
          height: (getExternalStorageDirectoriesPath.length + 1) * 20,
          child: ListView.builder(
              itemCount: getExternalStorageDirectoriesPath.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(getExternalStorageDirectoriesPath[index]);
              }),
        ),


      ],
    );
  }
}
