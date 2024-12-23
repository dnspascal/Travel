import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:travel/core/exceptions/api_exception.dart';
import 'package:travel/core/helpers/dio_exception_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  final logger = Logger();

  String? _accessToken;
  final List<String> _publicEndpoints = ['/auth/login', '/auth/register'];

  ApiService(this._dio, this._secureStorage) {
    _setupInterceptors();
    _dio.options.baseUrl = 'https://monarch-live-quickly.ngrok-free.app/api/v1';
  }

  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (!_publicEndpoints
            .any((endpoint) => options.path.contains(endpoint))) {
          _accessToken ??= await _secureStorage.read(key: 'access_token');
          if (_accessToken != null) {
            options.headers['Authorization'] = 'Bearer $_accessToken';
          } else {
            throw ApiException('Access token not found');
            // throw ApiException('An unexpected error occurred');
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

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data,
      {Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        ApiException apiException = handleDioError(e);

        throw apiException;
      } else {
        logger.e("Unexpected error: $e");
        throw ApiException('An unexpected error occurred: $e');
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
}
