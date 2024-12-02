import 'package:travel/domains/entities/user.dart';
import 'package:travel/domains/repositories/auth_repository.dart';

class RegisterUseCase {
  final IAuthRepository _authRepository;
  // final IPasswordValidator _passwordValidator;
  // final IEmailValidator _emailValidator;

  RegisterUseCase(
    this._authRepository,
    // this._passwordValidator,
    // this._emailValidator,
  );

  Future<User> execute({
    required String email,
    required String password,
    required String firstName,
    required String secondName,
    required String phoneNumber,
  }) async {
    // Validate email
    // if (!_emailValidator.isValid(email)) {
    //   throw ValidationException('Invalid email format');
    // }

    // // Validate password
    // final passwordValidation = _passwordValidator.validate(password);
    // if (!passwordValidation.isValid) {
    //   throw ValidationException(passwordValidation.message);
    // }

    // // Validate name
    // if (name.trim().length < 2) {
    //   throw ValidationException('Name must be at least 2 characters');
    // }

    return _authRepository.register(
        email, password, firstName, secondName, phoneNumber);
  }
}


// import '../entities/user_entity.dart';
// import '../repositories/auth_repository.dart';

// class RegisterUser {
//   final AuthRepository repository;

//   RegisterUser(this.repository);

//   Future<UserEntity> call(String name, String email, String password) {
//     return repository.register(name, email, password);
//   }
// }
