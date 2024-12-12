// import 'package:travel/domains/entities/user.dart';

// class UserDTO {
//   final int id;  // `id` is an integer from the response
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneNumber;
//   final DateTime lastLogin;
//   final DateTime dateJoined;
//   final bool isAdmin;

//   UserDTO({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phoneNumber,
//     required this.lastLogin,
//     required this.dateJoined,
//     required this.isAdmin,
//   });

//   // Factory method for creating a UserDTO from a JSON object
//   factory UserDTO.fromJson(Map<String, dynamic> json) {
//     return UserDTO(
//       id: json['id'],
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       email: json['email'],
//       phoneNumber: json['phone_number'],
//       lastLogin: DateTime.parse(json['last_login']),
//       dateJoined: DateTime.parse(json['date_joined']),
//       isAdmin: json['is_admin'],
//     );
//   }

//   // Method to convert UserDTO to Domain Entity (User)
//   User toDomain() {
//     return User(
//       id: id.toString(),  // Convert id (int) to String if needed for the User entity
//       firstName: firstName,
//       lastName: lastName,
//       email: email,
//       phoneNumber: phoneNumber,
//       lastLogin: lastLogin,
//       dateJoined: dateJoined,
//       isAdmin: isAdmin,
//       name: '$firstName $lastName', // Combine first and last name
//       createdAt: dateJoined, // Use dateJoined as createdAt for the User entity
//       isEmailVerified: false, // This can be updated based on your actual response
//     );
//   }
// }

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel/core/utils/capitalize.dart';
import '../../domains/entities/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDTO with _$UserDTO {
  const factory UserDTO({
    required int id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String email,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    @JsonKey(name: 'last_login') required DateTime lastLogin,
    @JsonKey(name: 'date_joined') required DateTime dateJoined,
    @JsonKey(name: 'is_admin') required bool isAdmin,
  }) = _UserDTO;

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  User toDomain() => User(
        id: id.toString(),
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        lastLogin: lastLogin,
        dateJoined: dateJoined,
        isAdmin: isAdmin,
        name: Capitalize.capitalizeEachWord('$firstName $lastName'),
        createdAt: dateJoined,
        isEmailVerified: false,
      );
}
