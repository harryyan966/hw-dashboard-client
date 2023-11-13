import 'package:client_auth/src/_.dart';
import 'package:hwdb_models/hwdb_models.dart';

class MockClientAuth implements ClientAuth {
  @override
  Future<User?> getCurrentUser() async {
    return null;
    // return const User(
    //   id: '0000000000000000000',
    //   name: 'Xiru',
    //   profile: '',
    //   role: Role.admin,
    // );
  }

  @override
  Future<void> signIn(String username, String password) async {
    // throw UnimplementedError();
  }
}
