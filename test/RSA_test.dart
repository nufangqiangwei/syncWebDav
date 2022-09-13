import 'package:flutter_test/flutter_test.dart';
import 'package:sync_webdav/common/encryption.dart';

Future<void> main() async {
  // var start = DateTime.now();
  // print(start);
  // var plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'* 3;
  // var encryptor = RsaEncrypt();
  // // await encryptor.test();
  // await encryptor.initKey();
  // var pass = await encryptor.encodeString(plainText);
  // print(pass);
  //
  // var out = await encryptor.decodeString(pass);
  // print(out);
  // print(DateTime.now());
  // print(DateTime.now().difference(start));
  var aes = AesEncrypt.initAes("]=[-p0o9]=[-p0o9");
  var encryStr = aes.encryptAes("和java不同，dart中的异常都是非检查异常，方法可以不声明可能抛出的异常，也不要求捕获任何异常。");
  print(encryStr);
  print(aes.decryptAes(encryStr));
}