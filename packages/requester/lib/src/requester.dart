import 'dart:async';

import 'package:client_auth/client_auth.dart';
import 'package:dio/dio.dart';
import 'package:general_utilities/general_utilities.dart';
import 'package:requester/requester.dart';
import 'package:requester/src/normalize_response.dart';

class Requester {
  Requester({
    required String baseURL,
    required TokenCacher tokenCacher,
  })  : _dio = Dio(
          BaseOptions(
            baseUrl: baseURL,
            responseType: ResponseType.plain,
          ),
        ),
        _tokenCacher = tokenCacher {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _processRequest,
        onResponse: _processResponse,
        onError: (e, _) => throw NetworkFailure(e.message),
      ),
    );
  }

  final Dio _dio;
  final TokenCacher _tokenCacher;

  Future<void> signIn(String userName, String passwordHash) async {
    final response = await post(
      '/auth/signin',
      data: {
        'userName': userName,
        'passwordHash': passwordHash,
      },
    );
    await _tokenCacher.setToken(response.get('token'));
  }

  Future<void> signOut() async {
    await get('/auth/signout');
    await _tokenCacher.setToken(null);
  }

  Future<JsonMap> get(String requestPath, {JsonMap? queryParams}) async {
    final response = await _dio.get<JsonMap>(requestPath, queryParameters: queryParams);
    return response.data!;
  }

  Future<JsonMap> post(String requestPath, {required JsonMap data, JsonMap? queryParams}) async {
    final response = await _dio.post<JsonMap>(
      requestPath,
      data: FormData.fromMap(data),
      queryParameters: queryParams,
    );
    return response.data!;
  }

  Future<JsonMap> put(String requestPath, {required JsonMap data, JsonMap? queryParams}) async {
    final response = await _dio.put<JsonMap>(
      requestPath,
      data: FormData.fromMap(data),
      queryParameters: queryParams,
    );
    return response.data!;
  }

  Future<JsonMap> patch(String requestPath, {required JsonMap data, JsonMap? queryParams}) async {
    final response = await _dio.patch<JsonMap>(
      requestPath,
      data: FormData.fromMap(data),
      queryParameters: queryParams,
    );
    return response.data!;
  }

  Future<JsonMap> delete(String requestPath, {JsonMap? queryParams}) async {
    final response = await _dio.delete<JsonMap>(requestPath, queryParameters: queryParams);
    return response.data!;
  }

  /// perform operations on the request options before the request is sent
  Future<void> _processRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(await _addAuthenticationToken(options));
  }

  /// perform operations on the response before the response is processed by other functions
  void _processResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    handler.next(normalizeResponse(response));
  }

  Future<RequestOptions> _addAuthenticationToken(RequestOptions options) async {
    final token = await _tokenCacher.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return options;
  }
}
