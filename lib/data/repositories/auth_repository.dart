import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travel/core/exceptions/api_exception.dart';
import 'package:travel/data/models/user_dto.dart';
import 'package:travel/data/services/api_service.dart';
import 'package:travel/domains/entities/user.dart';
import 'package:travel/domains/repositories/auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final ApiService _apiService;
  final FlutterSecureStorage _secureStorage;

  AuthRepository(this._apiService, this._secureStorage);

  @override
  Future<User> register(String email, String password, String firstName,
      String secondName, String phoneNumber) async {
    try {
      final response = await _apiService.post('/register', {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': secondName,
        'phone_number': phoneNumber,
      });

      await _secureStorage.write(key: 'auth_token', value: response['token']);

      final userDto = UserDTO.fromJson(response['user']);
      return userDto.toDomain();
    } on ApiException catch (e) {
      if (e.statusCode == 409) {
        throw ApiException('Email already registered');
      }
      throw ApiException('Registration failed: ${e.message}');
    } catch (e) {
      throw ApiException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      final response = await _apiService.post('/login', {
        'email': email,
        'password': password,
      });

      await _secureStorage.write(
          key: 'access_token', value: response['access']);
      await _secureStorage.write(
          key: 'refresh_token', value: response['refresh']);

      
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        throw ApiException('Invalid email or password');
      }
      throw ApiException('Login failed: ${e.message}');
    } catch (e) {
      throw ApiException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final token = await _secureStorage.read(key: 'auth_token');
      if (token != null) {
        final response = await _apiService.post('/auth/current_user', {});
        final userDto = UserDTO.fromJson(response['user']);
        return userDto.toDomain();
      } else {
        return null;
      }
    } on ApiException catch (e) {
      throw ApiException('Error fetching current user: ${e.message}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _secureStorage.delete(key: 'auth_token');
      await _apiService.post('/auth/logout', {});
    } on ApiException catch (e) {
      throw ApiException('Logout failed: ${e.message}');
    }
  }
}
