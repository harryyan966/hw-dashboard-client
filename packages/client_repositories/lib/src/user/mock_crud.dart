import 'package:client_repositories/src/user/interface.dart';
import 'package:hwdb_models/hwdb_models.dart';

class MockUserRepository extends UserRepository {
  const MockUserRepository();

  @override
  Future<void> create(User object) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<User?> read(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<User>> readAll({int? amount, bool detailed = false}) {
    throw UnimplementedError();
  }

  @override
  Future<void> update(String id, User object) {
    throw UnimplementedError();
  }
}
