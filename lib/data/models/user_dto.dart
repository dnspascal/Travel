import 'package:travel/domains/entities/user.dart';

class UserDTO {
  final int id;  // `id` is an integer from the response
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final DateTime lastLogin;
  final DateTime dateJoined;
  final bool isAdmin;

  UserDTO({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.lastLogin,
    required this.dateJoined,
    required this.isAdmin,
  });

  // Factory method for creating a UserDTO from a JSON object
  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      lastLogin: DateTime.parse(json['last_login']),
      dateJoined: DateTime.parse(json['date_joined']),
      isAdmin: json['is_admin'],
    );
  }

  // Method to convert UserDTO to Domain Entity (User)
  User toDomain() {
    return User(
      id: id.toString(),  // Convert id (int) to String if needed for the User entity
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      lastLogin: lastLogin,
      dateJoined: dateJoined,
      isAdmin: isAdmin,
      name: '$firstName $lastName', // Combine first and last name
      createdAt: dateJoined, // Use dateJoined as createdAt for the User entity
      isEmailVerified: false, // This can be updated based on your actual response
    );
  }
}
