class User {
  final String id; // `id` is now a String for consistency in your domain layer
  final String email;
  final String firstName;
  final String lastName;
  final String name;
  final DateTime createdAt;
  final bool isEmailVerified;
  final String? phoneNumber; // Optional field for phone_number
  final bool? isAdmin; // Optional field for is_admin
  final DateTime lastLogin; // Add `lastLogin` to match API response
  final DateTime dateJoined; // Add `dateJoined` to match API response

  // Constructor using named parameters
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.createdAt,
    required this.isEmailVerified,
    this.phoneNumber,
    this.isAdmin,
    required this.lastLogin,
    required this.dateJoined,
  });
}
