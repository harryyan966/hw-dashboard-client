import 'dart:io';

import 'package:dio/dio.dart';
import 'package:general_utilities/general_utilities.dart';
import 'package:requester/requester.dart';

/// converts dynamic responses to Json or throw exceptions
Response<JsonMap> normalizeResponse(Response<dynamic> response) {
  switch (response.statusCode) {
    case HttpStatus.ok || HttpStatus.created:
      return _processData(response);

    case HttpStatus.forbidden:
      throw const Forbidden();

    case HttpStatus.notFound:
      throw const NotFound();

    case HttpStatus.unauthorized:
      throw NotLoggedIn();

    case HttpStatus.badRequest || HttpStatus.conflict:
      return _processError(response);

    case HttpStatus.methodNotAllowed:
      throw const CompletelyUnexpected('client sent unrecognized http request');

    default:
      throw CompletelyUnexpected('server returned unrecognized status code ${response.statusCode}');
  }
}

Response<JsonMap> _processData(Response<dynamic> response) {
  // TODO(xiru): what is it?
  print('response.data: ${response.data}');
  // ignore: avoid_dynamic_calls
  print('response.data.runtimeType: ${response.data.runtimeType}');

  return Response(
    requestOptions: response.requestOptions,
    statusCode: response.statusCode,
    data: _dynamicToMap(response.data),
  );
}

Response<JsonMap> _processError(Response<dynamic> response) {
  // TODO(xiru): what is it?
  print('response.data: ${response.data}');
  // ignore: avoid_dynamic_calls
  print('response.data.runtimeType: ${response.data.runtimeType}');

  throw ResponseException(response.statusCode!, response.data.toString());
}

JsonMap _dynamicToMap(dynamic data) {
  return data.toString().toMap();
}
