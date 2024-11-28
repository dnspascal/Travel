import 'package:travel/domains/entities/user.dart';

abstract class IAuthRepository {
  Future<User> register(
      String email, String password, String name, String phoneNumber);
  Future<User> login(String email, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
}



