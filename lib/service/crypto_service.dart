import 'dart:convert';
import 'package:auth/config/config.dart';

class CryptoService {
  CryptoService({required this.config});

  final Config config;

  String encryptData(String data) {
    final dataBytes = utf8.encode(data);
    final saltBytes = utf8.encode(config.salt);

    final encrypted = <int>[];
    for (var i = 0; i < dataBytes.length; i++) {
      encrypted.add(dataBytes[i] ^ saltBytes[i % saltBytes.length]);
    }
    return base64.encode(encrypted);
  }

  String decryptData(String encryptedData) {
    final encryptedBytes = base64.decode(encryptedData);
    final saltBytes = utf8.encode(config.salt);

    final decrypted = <int>[];
    for (var i = 0; i < encryptedBytes.length; i++) {
      decrypted.add(encryptedBytes[i] ^ saltBytes[i % saltBytes.length]);
    }
    return utf8.decode(decrypted);
  }
}
