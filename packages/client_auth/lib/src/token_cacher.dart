import 'package:cacher/cacher.dart';

class TokenCacher {
  const TokenCacher({required this.secureCacher});

  final SecureCacher secureCacher;

  static const tokenKey = '__TOKEN__';

  Future<String?> getToken() => secureCacher.get(tokenKey);

  Future<void> setToken(String? token) => secureCacher.set(tokenKey, token);
}
