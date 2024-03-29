import 'dart:io';
import 'package:logger/logger.dart';
// import 'package:logger/src/outputs/file_output.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:developer' as developer;

Logger? log;

initLog() async {
  try {
    Directory cachePath = await getTemporaryDirectory();
    log = Logger(
      output: FileOutput(file: File(path.join(cachePath.path, "qiangWei.log"))),
    );
    developer.log('log me', name: 'my.app.category');
  } catch (e,tr) {
    Map<String, dynamic> map = {};
    map['msg'] = e.toString();
    print('日志初始化报错：$tr');
  }
}
