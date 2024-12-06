import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String? message;
  final int? statusCode;
  final String? responseBody;  

  ApiException(this.message, {this.statusCode, this.responseBody});

  @override
  String toString() {
    return 'ApiException: $message (Status code: $statusCode)';
  }

  static ApiException fromDioError(DioException error) {
    String? responseBody;

    if (error.response != null && error.response!.data != null) {
      responseBody = error.response!.data.toString();
    }

    return ApiException(
      error.message,
      statusCode: error.response?.statusCode,
      responseBody: responseBody,
    );
  }
}
