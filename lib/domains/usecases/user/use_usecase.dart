import 'package:travel/domains/entities/user.dart';
import 'package:travel/domains/repositories/user_repositories.dart';

class UserUsecase {
  final IUser _user;

  UserUsecase(this._user);

  Future<User> call() {
    return _user.getUser();
  }
}
