import 'package:client_model_validators/client_model_validators.dart';
import 'package:client_repositories/src/user/interface.dart';
import 'package:client_repositories/src/util/web_crud.dart';
import 'package:hwdb_models/hwdb_models.dart';

import 'package:requester/requester.dart';

class WebUserRepositoryImpl extends UserRepository {
  WebUserRepositoryImpl(Requester requester)
      : _crud = WebCRUD(
          requester: requester,
          queryAt: 'user',
          dataAt: 'user',
          fromJson: User.fromJson,
          toJson: (user) => user.toRequestJson(),
          validate: (user) => user.validate(),
        );

  final WebCRUD<User> _crud;

  @override
  Future<void> create(User object) => _crud.create(object);

  @override
  Future<void> delete(String id) => _crud.delete(id);

  @override
  Future<User?> read(String id) => _crud.read(id);

  @override
  Future<List<User>> readAll({int? amount, bool detailed = false}) => _crud.readAll(amount: amount, detailed: detailed);

  @override
  Future<void> update(String id, User object) => _crud.update(id, object);
}
