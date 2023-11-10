import 'package:client_repositories/src/util/crud.dart';
import 'package:hwdb_models/hwdb_models.dart';

abstract class UserRepository extends CRUDRepository<User> {
  const UserRepository();
}
