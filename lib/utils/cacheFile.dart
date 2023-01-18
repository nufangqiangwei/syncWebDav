import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:sync_webdav/common/Global.dart';

class CacheFile{

  /// 图片路径通过MD5处理，然后缓存到本地
  static void saveImageToLocal(Uint8List mUInt8List, String name) async {
    String path = await _getCachePathString(name);
    var file = File(path);
    bool exist = await file.exists();
    if (!exist) {
      File(path).writeAsBytesSync(mUInt8List);
    }
  }

  /// 从本地拿图片
  static Future<Uint8List?> getImageFromLocal(String name) async {
    String path = await _getCachePathString(name);
    var file = File(path);
    bool exist = await file.exists();
    if (exist) {
      final Uint8List bytes = await file.readAsBytes();
      return bytes;
    }
    return null;
  }


  /// 删除文件
  static removeFile(String name) async{
    String path = await _getCachePathString(name);
    File file = File(path);
    await file.delete();
  }
  /// 获取图片的缓存路径并创建
  static Future<String> _getCachePathString(String name) async {
    // 获取图片的名称
    String filePathFileName = md5.convert(convert.utf8.encode(name)).toString();
    String extensionName = name.split('/').last.split('.').last;

    // print('图片url:$name');
    // print('filePathFileName:$filePathFileName');
    // print('extensionName:$extensionName');

    // 生成、获取结果存储路径
    // final tempDic = await getTemporaryDirectory();
    // print(tempDic.path);
    Directory directory = Directory(globalParams.cachePath + '/CacheImage/');
    bool isFoldExist = await directory.exists();
    if (!isFoldExist) {
      await directory.create();
    }
    return directory.path + filePathFileName + '.$extensionName';
  }
}