class CompletelyUnexpected implements Error {
  const CompletelyUnexpected(this.error);

  final String error;

  @override
  String toString() {
    return 'Error: $error';
  }

  @override
  StackTrace? get stackTrace => StackTrace.current;
}

class NotLoggedIn implements Exception {
  @override
  String toString() => 'User not logged In';
}

class NetworkFailure implements Exception {
  const NetworkFailure(this.message);

  final String? message;

  @override
  String toString() => 'Network Failure: $message';
}

class ResponseException implements Exception {
  const ResponseException(this.statusCode, this.error);

  final int statusCode;
  final String error;

  @override
  String toString() {
    return 'ResponseException: $error';
  }
}

class NotFound extends ResponseException {
  const NotFound() : super(404, 'Not Found');
}

class Forbidden extends ResponseException {
  const Forbidden() : super(403, 'Forbidden');
}
