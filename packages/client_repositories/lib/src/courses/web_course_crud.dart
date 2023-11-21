import 'package:client_repositories/src/courses/course_crud.dart';
import 'package:client_repositories/src/util/web_crud.dart';
import 'package:hwdb_models/hwdb_models.dart';

import 'package:requester/requester.dart';

class WebCourseRepositoryImpl extends CourseRepository {
  WebCourseRepositoryImpl(Requester requester)
      : _crud = WebCRUD(
          requester: requester,
          queryAt: 'course',
          dataAt: 'course',
          fromJson: Course.fromJson,
          toJson: (course) => course.toJson(),
          validate: (course) => course.validate(),
        );

  final WebCRUD<Course> _crud;

  @override
  Future<void> create(Course object) => _crud.create(object);

  @override
  Future<void> delete(String id) => _crud.delete(id);

  @override
  Future<void> update(String id, Course object) => _crud.update(id, object);

  @override
  Future<List<Course>> getAll({int? amount, bool detailed = false, String? keyword}) =>
      _crud.getAll(amount: amount, detailed: detailed, keyword: keyword);

  @override
  Future<List<Course>> getAllByID(List<String> ids, {bool detailed = false}) =>
      _crud.getAllByID(ids, detailed: detailed);

  @override
  Future<Course?> getByID(String id, {bool detailed = true}) => _crud.getByID(id);
}
