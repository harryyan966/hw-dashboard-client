import 'package:client_repositories/src/util/crud.dart';
import 'package:hwdb_models/hwdb_models.dart';

abstract class CourseRepository extends CRUDRepository<Course> {
  const CourseRepository();
}
