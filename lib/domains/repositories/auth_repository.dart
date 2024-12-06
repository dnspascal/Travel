import 'package:travel/domains/entities/user.dart';

abstract class IAuthRepository {
  Future<User> register(String email, String password, String firstName,
      String secondName, String phoneNumber);
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
}
