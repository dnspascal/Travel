// class User {
//   final String id;
//   final String email;
//   final String firstName;
//   final String lastName;
//   final String name;
//   final DateTime createdAt;
//   final bool isEmailVerified;
//   final String? phoneNumber;
//   final bool? isAdmin;
//   final DateTime lastLogin;
//   final DateTime dateJoined;
//   User({
//     required this.id,
//     required this.email,
//     required this.firstName,
//     required this.lastName,
//     required this.name,
//     required this.createdAt,
//     required this.isEmailVerified,
//     this.phoneNumber,
//     this.isAdmin,
//     required this.lastLogin,
//     required this.dateJoined,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'first_name': firstName,
//       'last_name': lastName,
//       'name': name,
//       'created_at': createdAt.toIso8601String(),
//       'is_email_verified': isEmailVerified,
//       'phone_number': phoneNumber,
//       'is_admin': isAdmin,
//       'last_login': lastLogin.toIso8601String(),
//       'date_joined': dateJoined.toIso8601String(),
//     };
//   }

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       email: json['email'],
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       name: json['name'],
//       createdAt: DateTime.parse(json['created_at']),
//       isEmailVerified: json['is_email_verified'],
//       phoneNumber: json['phone_number'],
//       isAdmin: json['is_admin'],
//       lastLogin: DateTime.parse(json['last_login']),
//       dateJoined: DateTime.parse(json['date_joined']),
//     );
//   }

//   @override
//   String toString() {
//     return 'User(id: $id, name: $name, email: $email)';
//   }
// }

// lib/domains/entities/user.dart
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'user.freezed.dart';
// part 'user.g.dart';

// @freezed
// class User with _$User {
//   const factory User({
//     required String id,
//     required String email,
//     @JsonKey(name: 'first_name') required String firstName,
//     @JsonKey(name: 'last_name') required String lastName,
//     required String name,
//     @JsonKey(name: 'created_at') required DateTime createdAt,
//     @JsonKey(name: 'is_email_verified') @Default(false) bool isEmailVerified,
//     @JsonKey(name: 'phone_number') String? phoneNumber,
//     @JsonKey(name: 'is_admin') bool? isAdmin,
//     @JsonKey(name: 'last_login') required DateTime lastLogin,
//     @JsonKey(name: 'date_joined') required DateTime dateJoined,
//   }) = _User;

//   // JSON serialization methods are now generated
//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String name,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'is_email_verified') @Default(false) bool isEmailVerified,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'is_admin') bool? isAdmin,
    @JsonKey(name: 'last_login') required DateTime lastLogin,
    @JsonKey(name: 'date_joined') required DateTime dateJoined,
  }) = _User;

  // JSON serialization methods are now generated
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
