import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt_io.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class RsaEncrypt {
  late Encrypter encrypter;

  RsaEncrypt.initKey(String publicKeyStr,String privateKeyStr) {
    // var publicKeyStr =
    //     await File('assets/data/rsa_public_key.pem').readAsString();
    // var privateKeyStr =
    //     await File('assets/data/rsa_private_key.pem').readAsString();
    dynamic publicKey = RSAKeyParser().parse(publicKeyStr);
    dynamic privateKey = RSAKeyParser().parse(privateKeyStr);
    encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privateKey));
  }

  Future<String> encodeString(String content) async {
    List<int> sourceBytes = utf8.encode(content);
    int inputLen = sourceBytes.length;
    int maxLen = 117;
    List<int> totalBytes = <int>[];
    for (var i = 0; i < inputLen; i += maxLen) {
      int endLen = inputLen - i;
      List<int> item;
      if (endLen > maxLen) {
        item = sourceBytes.sublist(i, i + maxLen);
      } else {
        item = sourceBytes.sublist(i, i + endLen);
      }
      totalBytes.addAll(encrypter.encryptBytes(item).bytes);
    }
    return base64.encode(totalBytes);
    // return encrypter.encrypt(content).base64.toUpperCase();
  }

  Future<String> decodeString(String content) async {
    Uint8List sourceBytes = base64.decode(content);
    int inputLen = sourceBytes.length;
    int maxLen = 128;
    List<int> totalBytes = <int>[];
    for (var i = 0; i < inputLen; i += maxLen) {
      int endLen = inputLen - i;
      Uint8List item;
      if (endLen > maxLen) {
        item = sourceBytes.sublist(i, i + maxLen);
      } else {
        item = sourceBytes.sublist(i, i + endLen);
      }
      totalBytes.addAll(encrypter.decryptBytes(Encrypted(item)));
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
