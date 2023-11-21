import 'package:client_repositories/src/user/user_crud.dart';
import 'package:client_repositories/src/util/web_crud.dart';
import 'package:hwdb_models/hwdb_models.dart';

import 'package:requester/requester.dart';

// TODO(xiru): find a better solution than redirecting all functions, maybe mixins?

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
  Future<void> update(String id, User object) => _crud.update(id, object);

  @override
  Future<List<User>> getAll({int? amount, bool detailed = false, String? keyword}) =>
      _crud.getAll(amount: amount, detailed: detailed, keyword: keyword);

  @override
  Future<List<User>> getAllByID(List<String> ids, {bool detailed = false}) => _crud.getAllByID(ids, detailed: detailed);

  @override
  Future<User?> getByID(String id, {bool detailed = true}) => _crud.getByID(id);
}
