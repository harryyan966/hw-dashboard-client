import 'package:client_model_validators/client_model_validators.dart';
import 'package:client_repositories/src/courses/interface.dart';
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
  Future<Course?> read(String id) => _crud.read(id);

  @override
  Future<List<Course>> readAll({int? amount, bool detailed = false}) => _crud.readAll(amount: amount, detailed: detailed);

  @override
  Future<void> update(String id, Course object) => _crud.update(id, object);
}
