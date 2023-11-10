import 'dart:async';

import 'package:cacher/src/cacher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCacher extends Cacher {
  const SecureCacher({required this.storage});

  final FlutterSecureStorage storage;

  @override
  Future<String?> get(String key) async {
    return storage.read(key: key);
  }

  @override
  Future<void> set(String key, String? value) async {
    if (value == null) {
      await storage.delete(key: key);
    } else {
      await storage.write(key: key, value: value);
    }
  }
}
