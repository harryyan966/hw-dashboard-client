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

  @override
  Future<void> create(T object) async {
    validate(object);
    await requester.post(queryAt, data: toJson(object));
  }

  @override
  Future<T?> getByID(String id, {bool detailed = true}) async {
    try {
      final response = await requester.get(queryAt, queryParams: {'id': id, 'detailed': detailed});
      final object = fromJson(response.get(dataAt));
      validate(object);
      return object;
    } on NotFound {
      return null;
    }
  }

  @override
  Future<List<T>> getAllByID(List<String> ids, {bool detailed = false}) async {
    final response = await requester.get(
      queryAt,
      queryParams: {'ids': ids, 'detailed': detailed},
    );
    return _processListResponse(response);
  }

  // TODO(xiru): implement caching
  @override
  Future<List<T>> getAll({int? amount, bool detailed = false, String? keyword}) async {
    final queryParams = <String, dynamic>{};

    if (keyword != null && keyword.isNotEmpty) {
      queryParams['keyword'] = keyword;
    }

    queryParams['amount'] = amount;
    queryParams['detailed'] = detailed;

    final response = await requester.get(
      queryAt,
      queryParams: queryParams,
    );
    return _processListResponse(response);
  }

  List<T> _processListResponse(JsonMap response) {
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
