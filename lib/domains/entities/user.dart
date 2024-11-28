class User {
  final String id;
  final String email;
  final String name;
  final DateTime createdAt;
  final bool isEmailVerified;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
    required this.isEmailVerified,
  });
}
