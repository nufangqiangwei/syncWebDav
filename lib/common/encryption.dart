import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart';


class RsaEncrypt {
  late Encrypter _encrypter;
  late RSAPublicKey publicKey;
  late RSAPrivateKey privateKey;
  late int pubKeyLength;

  RsaEncrypt();

  RsaEncrypt.initKey(String publicKeyStr, String privateKeyStr) {
    // var publicKeyStr =
    //     await File('assets/data/rsa_public_key.pem').readAsString();
    // var privateKeyStr =
    //     await File('assets/data/rsa_private_key.pem').readAsString();
    publicKey = RSAKeyParser().parse(publicKeyStr) as RSAPublicKey;
    privateKey = RSAKeyParser().parse(privateKeyStr) as RSAPrivateKey;
    _encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privateKey));
  }

  int getEncodeBlockSize(){
    final modulus = publicKey.modulus;
    if (modulus!=null) {
      return modulus.bitLength ~/8-11;
    }
    return 0;
  }
  int getDecodeBlockSize(){
    final modulus = publicKey.modulus;
    if (modulus!=null) {
      return modulus.bitLength ~/8;
    }
    return 0;
  }
  // 加密
  String encodeString(String content) {
    List<int> sourceBytes = utf8.encode(content);
    int inputLen = sourceBytes.length;
    int maxLen = getEncodeBlockSize();
    List<int> totalBytes = <int>[];
    for (var i = 0; i < inputLen; i += maxLen) {
      int endLen = inputLen - i;
      List<int> item;
      if (endLen > maxLen) {
        item = sourceBytes.sublist(i, i + maxLen);
      } else {
        item = sourceBytes.sublist(i, i + endLen);
      }
      totalBytes.addAll(_encrypter.encryptBytes(item).bytes);
    }
    return base64.encode(totalBytes);
    // return encrypter.encrypt(content).base64.toUpperCase();
  }

  // 解密
  String decodeString(String content) {
    Uint8List sourceBytes = base64.decode(content);
    int inputLen = sourceBytes.length;
    int maxLen = getDecodeBlockSize();
    List<int> totalBytes = <int>[];
    for (var i = 0; i < inputLen; i += maxLen) {
      int endLen = inputLen - i;
      Uint8List item;
      if (endLen > maxLen) {
        item = sourceBytes.sublist(i, i + maxLen);
      } else {
        item = sourceBytes.sublist(i, i + endLen);
      }
      totalBytes.addAll(_encrypter.decryptBytes(Encrypted(item)));
    }
    return utf8.decode(totalBytes);
  }
}

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
