import 'dart:math';

import 'package:client_repositories/src/courses/course_crud.dart';
import 'package:hwdb_models/hwdb_models.dart';

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
  Future<Course?> getByID(String id, {bool detailed = true}) async {
    return const Course(
      id: 'course1',
      teacherID: 'julianaXu',
      name: 'AP Art History',
      description: 'Art history',
      grade: 12,
      year: 2023,
      startTime: StartTime.fall,
      detail: CourseDetail(studentIDs: ['student1', 'student2'], assignmentIDs: ['assignment1', 'assignment2']),
    );
  }

  @override
  Future<List<Course>> getAllByID(List<String> ids, {bool detailed = false}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Course>> getAll({int? amount, bool detailed = false, String? keyword}) async {
    const course = Course(
      id: 'course1',
      teacherID: 'julianaXu',
      name: 'AP Art History',
      description: 'Art history',
      grade: 12,
      year: 2023,
      startTime: StartTime.fall,
    );
    // TODO(xiru): implement readall
    // TODO(xiru): test lazy loading
    if (amount == null) {
      return [for (int i = 0; i < 100; i++) course];
    } else {
      return [for (int i = 0; i < max(amount, 100); i++) course];
    }
  }

  @override
  Future<void> update(String id, Course object) {
    throw UnimplementedError();
  }
}
