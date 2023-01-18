import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../common/Global.dart';
import '../common/cacheNetImage.dart';
import '../utils/cacheFile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Logger? log;

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("主页"),
      ),
      body: const ShowRandomImagePage(),
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
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
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
    return const Image(
      image: MyLocalCacheNetworkImage(
        "http://5b0988e595225.cdn.sohucs.com/images/20180927/6bdf291f885846ef8b110eba21b24d5d.jpeg",
        isLocalCache: true,
      ),
      fit: BoxFit.fill,
    );
  }
}

class ShowRandomImagePage extends StatefulWidget {
  const ShowRandomImagePage({Key? key}) : super(key: key);

  @override
  State<ShowRandomImagePage> createState() => _ShowRandomImagePage();
}

class _ShowRandomImagePage extends State<ShowRandomImagePage> {
  late Widget firstImage;
  late Widget secondImage;
  late bool _first = true;
  late List<String> imageUrlList = [];
  late int showImageIndex = 0;

  @override
  initState() {
    super.initState();
    String imageUrlFile = path.join(globalParams.cachePath, 'imageUrl');
    File file = File(imageUrlFile);
    if (!file.existsSync()) {
      file.create();
      firstImage = Image.asset("assets/images/index.jpg");
      secondImage = Image.asset("assets/images/index1.jpg");
      getImage();
      return;
    }
    String fileData = file.readAsStringSync();
    if (fileData == "") {
      firstImage = Image.asset("assets/images/index.jpg");
      secondImage = Image.asset("assets/images/index1.jpg");
      getImage();
      return;
    }
    imageUrlList = jsonDecode(fileData).cast<String>();
    firstImage =
        Image(image: MyLocalCacheNetworkImage(imageUrlList[showImageIndex]));
    showImageIndex++;
    secondImage =
        Image(image: MyLocalCacheNetworkImage(imageUrlList[showImageIndex]));
  }

  Future<void> switchImage() async {
    showImageIndex++;

    if (showImageIndex >= imageUrlList.length) {
      showImageIndex = 0;
    }
    if (showImageIndex + 4 >= imageUrlList.length) {
      getImage();
    }
    if (imageUrlList.isNotEmpty) {
      if (_first) {
        secondImage =
            Image(image: MyLocalCacheNetworkImage(imageUrlList[showImageIndex]));
      } else {
        firstImage =
            Image(image: MyLocalCacheNetworkImage(imageUrlList[showImageIndex]));
      }
    }

    setState(() {
      _first = !_first;
    });
  }

  findImage() async {
    Directory folder = Directory(globalParams.cachePath);
    int imageNumber = 0;
    await for (FileSystemEntity fileSystemEntity in folder.list()) {
      FileSystemEntityType type =
          FileSystemEntity.typeSync(fileSystemEntity.path);
      if (type == FileSystemEntityType.file) {
        imageNumber++;
      }
    }
    if (imageNumber < 4) {
      getImage();
    }
  }

  Future<List<String>?> getImageList() async {
    HttpClient client = HttpClient()..autoUncompress = false;
    final Uri resolved = Uri.base.resolve("http://192.168.111.45:5000/password/api/getRandImageList");
    final HttpClientRequest request = await client.getUrl(resolved);
    final HttpClientResponse response = await request.close();
    final stringData = await response.transform(utf8.decoder).join();
    Map<String, dynamic> data = jsonDecode(stringData);
    List<String> urls = data['msg'].cast<String>();
    return urls;
  }

  getImage() async {
    List<String>? urls = await getImageList();
    if (urls == null) {
      return;
    }

    HttpClient client = HttpClient()..autoUncompress = false;
    for (var i = 0; i < urls.length; i++) {
      final Uri resolved = Uri.base.resolve(urls[i]);
      final HttpClientRequest request = await client.getUrl(resolved);
      final HttpClientResponse response = await request.close();
      if (response.statusCode != HttpStatus.ok) {
        // The network may be only temporarily unavailable, or the file will be
        // added on the server later. Avoid having future calls to resolve
        // fail to check the network again.
        throw NetworkImageLoadException(
            statusCode: response.statusCode, uri: resolved);
      }
      final Uint8List bytes =
          await consolidateHttpClientResponseBytes(response);
      CacheFile.saveImageToLocal(bytes, urls[i]);
      imageUrlList.add(urls[i]);
    }
    String imageUrlFile = path.join(globalParams.cachePath, 'imageUrl');
    File file = File(imageUrlFile);
    await file.writeAsString(jsonEncode(imageUrlList));
  }

  @override
  Widget build(BuildContext context) {
    Size windowsSize = MediaQuery.of(context).size;

    // SizedBox(
    //   width: windowsSize.width,
    //   height: windowsSize.height + 50,
    //   child: AnimatedCrossFade(
    //     firstChild: firstImage,
    //     secondChild: secondImage,
    //     crossFadeState:
    //     _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    //     duration: const Duration(seconds: 2),
    //   ),
    // )


    return RefreshIndicator(
      //圆圈进度颜色
      // color: Colors.blue,
      //下拉停止的距离
      // displacement: 44.0,
      //背景颜色
      // backgroundColor: Colors.grey[200],
      onRefresh: switchImage,
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: windowsSize.height + 50,maxWidth:windowsSize.width),
          child: AnimatedCrossFade(
            firstChild: firstImage,
            secondChild: secondImage,
            crossFadeState:
            _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(seconds: 2),
          ),
        ),
      ),
    );
  }
}
