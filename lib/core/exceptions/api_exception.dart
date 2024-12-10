import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiException implements Exception {
  final String? message;
  final String? statusCode;
  final String? responseBody;

  ApiException(this.message, {this.statusCode, this.responseBody});

  @override
  String toString() {
    return 'ApiException: $message (Status code: $statusCode)';
  }

  static ApiException fromDioError(DioException error) {
    String? responseBody;
    debugPrint("$error, THIS IS WHAT IS CAUSING THE ERROR");

    if (error.response != null && error.response!.data != null) {
      try {
        responseBody = error.response!.data.toString();
      } catch (e) {
        responseBody = 'Error parsing response body: $e';
      }
    }

    return ApiException(
      error.message,
      statusCode: error.response?.statusCode?.toString(),
      responseBody: responseBody,
    );
  }
}
