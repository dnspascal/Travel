import 'package:dio/dio.dart';
import 'package:travel/core/exceptions/api_exception.dart';

ApiException handleDioError(DioException e) {
  ApiException apiException = ApiException.fromDioError(e);

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      apiException = ApiException(
          'The connection timed out. Please check your internet connection and try again.',
          responseBody: apiException.responseBody);
      break;

    case DioExceptionType.sendTimeout:
      apiException = ApiException(
          'The request timed out while sending data. Please try again later.',
          responseBody: apiException.responseBody);
      break;

    case DioExceptionType.receiveTimeout:
      apiException = ApiException(
          'The server took too long to respond. Please try again later.',
          responseBody: apiException.responseBody);
      break;

    case DioExceptionType.cancel:
      apiException = ApiException(
          'The request was cancelled. Please try again.',
          responseBody: apiException.responseBody);
      break;

    case DioExceptionType.connectionError:
      apiException = ApiException(
          'There was an error connecting to the server. Please check your connection and try again.',
          responseBody: apiException.responseBody);
      break;

    case DioExceptionType.badResponse:
      apiException = ApiException(
        '${e.response?.data}',
        statusCode: e.response?.statusCode.toString(),
        responseBody: apiException.responseBody,
      );
      break;

    case DioExceptionType.unknown:
    default:
      apiException = ApiException('An unexpected error occurred',
          responseBody: apiException.responseBody);
  }

  return apiException;
}
