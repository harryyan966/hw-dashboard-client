import 'package:client_repositories/client_repositories.dart';
import 'package:general_utilities/general_utilities.dart';
import 'package:requester/requester.dart';

// TODO(xiru): async validation

class WebCRUD<T> extends CRUDRepository<T> {
  WebCRUD({
    required this.requester,
    required this.queryAt,
    required this.dataAt,
    required this.fromJson,
    required this.toJson,
    required this.validate,
  });

  final Requester requester;

  final String queryAt;
  final String dataAt;
  final T Function(JsonMap json) fromJson;
  final JsonMap Function(T object) toJson;
  final void Function(T object) validate;

  final List<T> _cachedObjects = [];

  @override
  Future<void> create(T object) async {
    validate(object);
    await requester.post(queryAt, data: toJson(object));
  }

  @override
  Future<T?> read(String id) async {
    try {
      final response = await requester.get(queryAt, queryParams: {'id': id});
      final object = fromJson(response.get(dataAt));
      validate(object);
      return object;
    } on NotFound {
      return null;
    }
  }

  /// read 'all' with lazy loading
  @override
  Future<List<T>> readAll({int? amount, bool detailed = false}) async {
    if (amount != null) {
      if (amount <= _cachedObjects.length) {
        return _cachedObjects;
      }
    }
    final response = await requester.get(
      queryAt,
      queryParams: {
        'start': _cachedObjects.length,
        'end': amount,
        'detailed': detailed,
      },
    );
    final returnedObjects = parseListResponse(response);
    return [..._cachedObjects, ...returnedObjects];
  }

  List<T> parseListResponse(JsonMap response) {
    final data = response.get<List<JsonMap>>(dataAt);
    final objectList = data.map(fromJson).toList();
    for (final object in objectList) {
      validate(object);
    }
    return objectList;
  }

  @override
  Future<void> update(String id, T object) async {
    validate(object);
    await requester.put(queryAt, data: toJson(object));
  }

  Future<void> updateParts(String id, JsonMap parts) async {
    // TODO(xiru): check if parts exist
    await requester.patch(queryAt, data: parts);
  }

  @override
  Future<void> delete(String id) async {
    await requester.delete(queryAt, queryParams: {'id': id});
  }
}
