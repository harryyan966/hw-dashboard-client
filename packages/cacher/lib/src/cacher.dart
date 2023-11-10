import 'dart:async';

abstract class Cacher {
  const Cacher();

  FutureOr<String?> get(String key);

  Future<void> set(String key, String? value);
}
