import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:travel/data/repositories/auth_repository.dart';
import 'package:travel/data/repositories/user_repository.dart';
import 'package:travel/data/services/api_service.dart';
import 'package:travel/domains/repositories/auth_repository.dart';
import 'package:travel/domains/repositories/user_repositories.dart';
import 'package:travel/domains/usecases/auth/login_usecase.dart';
import 'package:travel/domains/usecases/auth/register_usecase.dart';
import 'package:travel/domains/usecases/user/use_usecase.dart';
import 'package:travel/modules/auth/controllers/auth_controller.dart';
import 'package:travel/modules/auth/controllers/login_controller.dart';
// import 'package:travel/data/services/api_service.dart';
// import 'package:travel/domains/repositories/auth_repository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Core services
    Get.lazyPut(() => Dio(BaseOptions(
        // baseUrl: 'http://127.0.0.1:8517/',
        // connectTimeout: const Duration(seconds: 5),
        // receiveTimeout: const Duration(seconds: 3),
        )));

    Get.lazyPut(() => const FlutterSecureStorage());
    Get.lazyPut(() => ApiService(Get.find(), Get.find()));
    Get.lazyPut(() => LoginController(Get.find(), Get.find()));

    // // Validators
    // Get.lazyPut(() => EmailValidator());
    // Get.lazyPut(() => PasswordValidator());

    // // Repositories
    Get.lazyPut<IAuthRepository>(() => AuthRepository(
          Get.find(),
          Get.find(),
        ));
    Get.lazyPut<IUser>(() => UserRepository(
          Get.find(),
        ));
  

    // // Use cases
    Get.lazyPut(() => RegisterUseCase(
          Get.find(),
          // Get.find(),
          // Get.find(),
        ));
    Get.lazyPut(() => LoginUseCase(
          Get.find(),
          // Get.find(),
        ));
    Get.lazyPut(() => UserUsecase(
          Get.find(),
          // Get.find(),
        ));

    // // Controllers
    Get.lazyPut(() => AuthController(
          Get.find(),
          Get.find(),
        ));
  }
}
