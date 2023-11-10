import 'package:client_repositories/src/courses/interface.dart';
import 'package:hwdb_models/hwdb_models.dart';
import 'package:requester/requester.dart';

class MockCourseRepository extends CourseRepository {
  const MockCourseRepository();

  @override
  Future<void> create(Course object) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Course?> read(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Course>> readAll({int? amount, bool detailed = false}) async {
    throw NotLoggedIn();
  }

  @override
  Future<void> update(String id, Course object) {
    throw UnimplementedError();
  }
}
