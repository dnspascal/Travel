import 'package:travel/data/models/user_dto.dart';
import 'package:travel/data/services/api_service.dart';
import 'package:travel/domains/entities/user.dart';
import 'package:travel/domains/repositories/user_repositories.dart';

class UserRepository implements IUser {
  final ApiService _apiService;

  UserRepository(this._apiService);

  @override
  Future<User> getUser() async {
    try {
      final response = await _apiService.get('/user');
      print("THIS IS THE RESPONSE");
      print(response);

      final userDTO = UserDTO.fromJson(response);

      // Convert UserDTO to User (Domain Entity)
      return userDTO.toDomain();
    } catch (e) {
      print("THIS IS THE ERROR now");
      print(e);
      throw Exception('Failed to fetch user data: $e');
    }
  }
}
