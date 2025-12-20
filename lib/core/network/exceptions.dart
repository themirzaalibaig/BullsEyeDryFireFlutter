class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message: message);
}

class ServerException extends AppException {
  ServerException({required String message, int? statusCode})
      : super(message: message, statusCode: statusCode);
}

class CancelException extends AppException {
  CancelException(String message) : super(message: message);
}

class UnknownException extends AppException {
  UnknownException(String message) : super(message: message);
}

