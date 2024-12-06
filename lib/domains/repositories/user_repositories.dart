import 'package:travel/domains/entities/user.dart';

abstract class IUser {
  Future<User> getUser();
}
