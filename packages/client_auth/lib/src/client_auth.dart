import 'dart:convert';

import 'package:cacher/cacher.dart';
import 'package:client_model_validators/client_model_validators.dart';
import 'package:crypto/crypto.dart';
import 'package:general_utilities/general_utilities.dart';
import 'package:hwdb_models/hwdb_models.dart';
import 'package:requester/requester.dart';

class ClientAuth {
  const ClientAuth({
    required QuickCacher quickCacher,
    required Requester requester,
  })  : _quickCacher = quickCacher,
        _requester = requester;

  final QuickCacher _quickCacher;
  final Requester _requester;

  static const userKey = '__TOKEN__';

  Future<User?> getCurrentUser() async {
    // try to get user from cache
    final cachedUser = _quickCacher.get(userKey);
    if (cachedUser != null) {
      return User.fromJson(cachedUser.toMap())..validate();
    }
    try {
      // if not working, get user with a request
      final response = await _requester.get('/auth/currentUser');
      final user = User.fromJson(response.get('user'))..validate();
      await _quickCacher.set(userKey, json.encode(user));
      return user;
    } on NotFound {
      return null;
    }
  }

  Future<void> signIn(String username, String password) async {
    final passwordHash = sha256.convert(utf8.encode(password)).toString();
    await _requester.signIn(username, passwordHash);
  }
}
