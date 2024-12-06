import 'package:travel/domains/entities/user.dart';
import 'package:travel/domains/repositories/auth_repository.dart';

class LoginUseCase {
  final IAuthRepository _authRepository;
  // final IEmailValidator _emailValidator;

  LoginUseCase(
    this._authRepository,
    // this._emailValidator
  );

  Future<void> execute(String email, String password) async {
    // if (!_emailValidator.isValid(email)) {
    //   throw ValidationException('Invalid email format');
    // }

    // if (password.isEmpty) {
    //   throw ValidationException('Password cannot be empty');
    // }

    return _authRepository.login(email, password);
  }
}





// import '../entities/user_entity.dart';
// import '../repositories/auth_repository.dart';

// class LoginUser {
//   final AuthRepository repository;

//   LoginUser(this.repository);

//   Future<UserEntity> call(String email, String password) {
//     return repository.login(email, password);
//   }
// }
