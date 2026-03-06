import 'dart:convert';

import 'package:auth/config/config.dart';
import 'package:crypto/crypto.dart';

class HashService {
  HashService({required this.config});

  final Config config;

  String hashPassword(String password) {
    final saltBytes = utf8.encode(config.salt);
    final passwordBytes = utf8.encode(password);
    final combined = [...passwordBytes, ...saltBytes];
    var hash = sha256.convert(combined);
    for (var i = 0; i < 100000; i++) {
      hash = sha256.convert(hash.bytes);
    }
    return base64.encode(hash.bytes);
  }

  bool verifyData(String password, String hashedPassword) {
    final hashed = hashPassword(password);
    return hashed == hashedPassword;
  }
}
