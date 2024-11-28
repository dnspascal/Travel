import 'package:travel/domains/entities/user.dart';

class UserDTO {
  final String id;
  final String email;
  final String name;
  final DateTime createdAt;
  final bool isEmailVerified;

  UserDTO.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      email = json['email'],
      name = json['name'],
      createdAt = DateTime.parse(json['created_at']),
      isEmailVerified = json['is_email_verified'] ?? false;

  User toDomain() => User(
    id: id,
    email: email,
    name: name,
    createdAt: createdAt,
    isEmailVerified: isEmailVerified,
  );
}