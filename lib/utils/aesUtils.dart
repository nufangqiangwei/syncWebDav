import 'package:encrypt/encrypt.dart';


class AesEncrypt {
  static late Key _keyAes;
  static late Encrypter _encryptAes;
  static final IV _ivAes = IV.fromLength(16);

  ///初始化AES加密启动时调用
  AesEncrypt.initAes(String key) {
    if (key.length == 16 || key.length == 24 || key.length == 32) {
      _keyAes = Key.fromUtf8(key);
      _encryptAes =
          Encrypter(AES(_keyAes, mode: AESMode.sic, padding: 'PKCS7'));
      return;
    }
    throw "密钥长度为16/24/32位";
  }

  ///Aes加密
  String encryptAes(String context) {
    return _encryptAes.encrypt(context, iv: _ivAes).base64;
  }

  ///Aes解密
  String decryptAes(String context) {
    return _encryptAes.decrypt(Encrypted.fromBase64(context), iv: _ivAes);
  }
}