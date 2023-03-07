import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Signal dbInit = Signal();

void main()  {
  testFunc();
  testFunc();
  testFunc();
  testFunc();
}

testFunc() async{
  save(1);
  save(2);
  save(3);
  save(4);
  sleep(const Duration(seconds: 1));
  stdout.writeln();
}

save(int mark) async {
  // print("开始执行： $mark");
  // await dbInit.lock;
  // print("$mark：获得锁");
  // await Future.delayed(const Duration(seconds: 3), () {
  //   print(mark);
  //   return "network data";
  // });
  // await dbInit.unLock;
  // print("执行完成：$mark");
  await writeSlow(mark);
}

read(String mark) async {
  await dbInit.unLock;
  print("读取日志:$mark");
}

class Signal {
  late Completer? _signal;

  Signal() : _signal = null;

  Future<void> get waitLock async{
    if(_signal != null){
      await _signal?.future;
    }
  }

  Future<void> get lock async {
    if(_signal != null) {
      await _signal?.future;
      _signal = null;
    }
    _signal = Completer<bool>();
  }

   get unLock  {
    _signal?.complete(true);
  }
}

/// write an int
Future<void> writeSlow(int value) async {
  await Future<void>.delayed(const Duration(milliseconds: 1));
  stdout.write(value);
}

/// write a list of int, 1 char every 1 ms
Future<void> write(List<int> values) async {
  for (var value in values) {
    await writeSlow(value);
  }
}