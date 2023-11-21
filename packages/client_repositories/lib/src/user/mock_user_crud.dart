import 'package:client_repositories/src/user/user_crud.dart';
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
  Future<User?> getByID(String id, {bool detailed = true}) async {
    if (id == 'julianaXu') {
      return const User(
        id: 'julianaXu',
        name: 'Juliana Xu',
        profile: 'https://picsum.photos/250?image=9',
        role: Role.teacher,
      );
    }
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAllByID(List<String> ids, {bool detailed = false}) {
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAll({int? amount, bool detailed = false, String? keyword}) {
    throw UnimplementedError();
  }

  @override
  Future<void> update(String id, User object) {
    throw UnimplementedError();
  }
}
