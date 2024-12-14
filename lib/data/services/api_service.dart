import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:travel/core/exceptions/api_exception.dart';

class ApiService {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  String? _accessToken;
  final List<String> _publicEndpoints = ['/login', '/register'];

  ApiService(this._dio, this._secureStorage) {
    _setupInterceptors();
    _dio.options.baseUrl = 'https://monarch-live-quickly.ngrok-free.app/';
  }

  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        print("Intercepting request for path: ${options.path}");
        if (!_publicEndpoints
            .any((endpoint) => options.path.contains(endpoint))) {
          print("Private endpoint detected");
          _accessToken ??= await _secureStorage.read(key: 'access_token');
          if (_accessToken != null) {
            options.headers['Authorization'] = 'Bearer $_accessToken';
            print("Authorization header added: Bearer $_accessToken");
          } else {
            print("No access token available for private endpoint");
          }
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final isRefreshed = await _handleTokenExpiration();
          if (isRefreshed) {
            final options = error.response!.requestOptions;
            options.headers['Authorization'] = 'Bearer $_accessToken';
            final retryResponse = await _dio.request(
              options.path,
              options: Options(
                method: options.method,
                headers: options.headers,
                contentType: options.contentType,
              ),
              data: options.data,
              queryParameters: options.queryParameters,
            );
            return handler.resolve(retryResponse);
          } else {
            Get.offAllNamed('/login');
          }
        }
        handler.next(error);
      },
    ));
  }

  Future<bool> _handleTokenExpiration() async {
    try {
      final refreshToken = await _secureStorage.read(key: 'refresh_token');
      if (refreshToken == null) return false;

      final response = await _dio.post('/auth/refresh', data: {
        'refresh_token': refreshToken,
      });

      final newAccessToken = response.data['access_token'];
      if (newAccessToken != null) {
        _accessToken = newAccessToken;
        await _secureStorage.write(key: 'access_token', value: newAccessToken);
        return true;
      }
      // ignore: empty_catches
    } catch (e) {}
    return false;
  }

  // Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data,
  //     {Map<String, dynamic>? headers}) async {
  //   try {
  //     // if (!_publicEndpoints.contains(endpoint) && headers == null) {
  //     //   throw ApiException('Headers are required for this endpoint.');
  //     // }

  //     debugPrint('Attempting POST request to $endpoint with data: $data and headers: $headers');

  //   final response = await _dio.post(
  //     endpoint,
  //     data: data,
  //     options: Options(headers: headers),
  //   );

  //   debugPrint("WE ARE PRINTING HERE NOW ON THE SERVICE");
  //   debugPrint(response.toString());
  //     return response.data;
  //   } catch (e) {
  //     if (e is DioException) {
  //       final errorData = e.response?.data;
  //       if (errorData != null) {
  //         final errorMessage = errorData['message'] ?? 'Unknown error';
  //         final errorStatus = errorData['status'] ?? 3;

  //         throw ApiException(
  //           errorMessage,
  //           statusCode: errorStatus,
  //         );
  //       }
  //       throw ApiException.fromDioError(e);
  //     } else {
  //       throw ApiException('Unknown error: ${e.toString()}');
  //     }
  //   }
  // }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data, {Map<String, dynamic>? headers}) async {
  try {
    if (!_publicEndpoints.contains(endpoint) && headers == null) {
      throw ApiException('Headers are required for this endpoint.');
    }

    final response = await _dio.post(
      endpoint,
      data: data,
      options: Options(headers: headers),
    );

    print("Response Data: ${response.data}");

    // Check if the response is an error message (status not 1)
    if (response.data['status'] != 1) {
      throw ApiException(response.data['message'] ?? 'Unknown error');
    }

    return response.data;
  } catch (e) {
    print("Error occurred: $e");

    if (e is DioException) {
      final errorData = e.response?.data;
      if (errorData != null) {
        // Handle specific cases based on error structure
        if (errorData is Map && errorData.containsKey('status')) {
          final errorMessage = errorData['message'] ?? 'Unknown error';
          final errorStatus = errorData['status'] ?? 3;
          throw ApiException(errorMessage, statusCode: errorStatus);
        } else if (errorData is List) {
          // Handle list errors
          throw ApiException(errorData.join(', '), statusCode: '401');
        }
      }
      throw ApiException.fromDioError(e);
    } else {
      throw ApiException('Unknown error: ${e.toString()}');
    }
  }
}


  Future get(String endpoint, {Map<String, dynamic>? headers}) async {
    try {
      final response =
          await _dio.get(endpoint, options: Options(headers: headers));
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // Future get(String endpoint, {Map<String, dynamic>? headers}) async {
  //   try {
  //     print("THIS ARE HEASERS");
  //     print(headers);
  //     if (!_publicEndpoints.contains(endpoint) && headers == null) {
  //       throw ApiException('Headers are required for this endpoint.');
  //     }

  //     final response =
  //         await _dio.get(endpoint, options: Options(headers: headers));
  //     return response.data;
  //   } on DioException catch (e) {
  //     throw ApiException.fromDioError(e);
  //   }
  // }
}

// import 'package:get/get.dart';
// import 'package:dio/dio.dart';
// import 'dart:async';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class ApiService {
//   final Dio _dio;
//   final SecureStorage _secureStorage;
//   final _maxRetries = 3;
//   bool _isRefreshing = false;
//   final _refreshTokenSubject = StreamController<void>.broadcast();

//   ApiService(this._dio, this._secureStorage) {
//     _setupInterceptors();
//     _setupBaseConfig();
//   }

//   void _setupBaseConfig() {
//     _dio.options = BaseOptions(
//       connectTimeout: const Duration(seconds: 30),
//       receiveTimeout: const Duration(seconds: 30),
//       sendTimeout: const Duration(seconds: 30),
//       validateStatus: (status) {
//         return status! < 500;
//       },
//     );
//   }

//   void _setupInterceptors() {
//     _dio.interceptors.clear();
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           // Add common headers
//           options.headers['Accept'] = 'application/json';
//           options.headers['Content-Type'] = 'application/json';

//           final token = await _secureStorage.read('auth_token');
//           if (token != null) {
//             options.headers['Authorization'] = 'Bearer $token';
//           }
//           return handler.next(options);
//         },
//         onResponse: (response, handler) {
//           // Log successful responses if needed
//           _logResponse(response);
//           return handler.next(response);
//         },
//         onError: (error, handler) async {
//           if (error.response?.statusCode == 401) {
//             if (!_isRefreshing) {
//               _isRefreshing = true;
//               try {
//                 await _refreshToken();
//                 _isRefreshing = false;
//                 _refreshTokenSubject.add(null);

//                 // Retry the original request
//                 final retryResponse = await _retry(error.requestOptions);
//                 return handler.resolve(retryResponse);
//               } catch (e) {
//                 _isRefreshing = false;
//                 await _handleTokenExpiration();
//                 return handler.next(error);
//               }
//             } else {
//               // Wait for token refresh to complete
//               await _refreshTokenSubject.stream.first;
//               final retryResponse = await _retry(error.requestOptions);
//               return handler.resolve(retryResponse);
//             }
//           }
//           return handler.next(error);
//         },
//       ),
//     );
//   }

//   Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
//     final token = await _secureStorage.read('auth_token');
//     final options = Options(
//       method: requestOptions.method,
//       headers: {
//         ...requestOptions.headers,
//         'Authorization': 'Bearer $token',
//       },
//     );

//     return _dio.request<dynamic>(
//       requestOptions.path,
//       data: requestOptions.data,
//       queryParameters: requestOptions.queryParameters,
//       options: options,
//     );
//   }

//   Future<void> _refreshToken() async {
//     try {
//       final refreshToken = await _secureStorage.read('refresh_token');
//       if (refreshToken == null) throw Exception('No refresh token found');

//       final response = await _dio.post(
//         '/auth/refresh',
//         data: {'refresh_token': refreshToken},
//       );

//       if (response.statusCode == 200) {
//         await _secureStorage.write('auth_token', response.data['access_token']);
//         await _secureStorage.write('refresh_token', response.data['refresh_token']);
//       } else {
//         throw Exception('Failed to refresh token');
//       }
//     } catch (e) {
//       throw Exception('Token refresh failed: $e');
//     }
//   }

//   Future<void> _handleTokenExpiration() async {
//     await _secureStorage.deleteAll();
//     Get.offAllNamed('/login');
//   }

//   void _logResponse(Response response) {
//     // Implement your logging logic here
//     print('API Response: ${response.statusCode} - ${response.requestOptions.path}');
//   }

//   // Generic request method with retry logic
//   Future<T> _request<T>(
//     String endpoint,
//     String method,
//     {
//       Map<String, dynamic>? data,
//       Map<String, dynamic>? queryParameters,
//       Options? options,
//     }
//   ) async {
//     int attempts = 0;
//     DioException? lastError;

//     while (attempts < _maxRetries) {
//       try {
//         final Response response = await _dio.request(
//           endpoint,
//           data: data,
//           queryParameters: queryParameters,
//           options: options?.copyWith(method: method) ?? Options(method: method),
//         );

//         return response.data as T;
//       } on DioException catch (e) {
//         lastError = e;

//         // Don't retry on client errors (4xx)
//         if (e.response?.statusCode != null && e.response!.statusCode! >= 400 && e.response!.statusCode! < 500) {
//           throw ApiException.fromDioError(e);
//         }

//         attempts++;
//         if (attempts == _maxRetries) break;

//         // Exponential backoff
//         await Future.delayed(Duration(milliseconds: pow(2, attempts) * 1000));
//       }
//     }

//     throw ApiException.fromDioError(lastError!);
//   }

//   // HTTP Methods
//   Future<T> get<T>(String endpoint, {Map<String, dynamic>? queryParameters}) async {
//     return _request<T>(
//       endpoint,
//       'GET',
//       queryParameters: queryParameters,
//     );
//   }

//   Future<T> post<T>(String endpoint, {Map<String, dynamic>? data}) async {
//     return _request<T>(
//       endpoint,
//       'POST',
//       data: data,
//     );
//   }

//   Future<T> put<T>(String endpoint, {Map<String, dynamic>? data}) async {
//     return _request<T>(
//       endpoint,
//       'PUT',
//       data: data,
//     );
//   }

//   Future<T> patch<T>(String endpoint, {Map<String, dynamic>? data}) async {
//     return _request<T>(
//       endpoint,
//       'PATCH',
//       data: data,
//     );
//   }

//   Future<T> delete<T>(String endpoint, {Map<String, dynamic>? data}) async {
//     return _request<T>(
//       endpoint,
//       'DELETE',
//       data: data,
//     );
//   }

//   void dispose() {
//     _refreshTokenSubject.close();
//   }
// }

// class ApiException implements Exception {
//   final String message;
//   final int? statusCode;
//   final dynamic data;

//   ApiException({
//     required this.message,
//     this.statusCode,
//     this.data,
//   });

//   factory ApiException.fromDioError(DioException error) {
//     String message;
//     int? statusCode = error.response?.statusCode;
//     dynamic data = error.response?.data;

//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.receiveTimeout:
//         message = 'Connection timed out';
//         break;
//       case DioExceptionType.connectionError:
//         message = 'No internet connection';
//         break;
//       case DioExceptionType.badResponse:
//         message = data?['message'] ?? 'Server error occurred';
//         break;
//       default:
//         message = 'Something went wrong';
//     }

//     return ApiException(
//       message: message,
//       statusCode: statusCode,
//       data: data,
//     );
//   }

//   @override
//   String toString() => message;
// }
