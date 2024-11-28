// import 'package:get/get.dart';
// import 'package:travel/core/exceptions/api_exception.dart';
// import 'package:travel/domains/entities/user.dart';
// import 'package:travel/domains/usecases/auth/login_usecase.dart';
// import 'package:travel/domains/usecases/auth/register_usecase.dart';

// class AuthController extends GetxController {
//   final RegisterUseCase _registerUseCase;
//   final LoginUseCase _loginUseCase;

//   final loading = false.obs;
//   final user = Rxn<User>();
//   final errorMessage = RxnString();

//   AuthController(this._registerUseCase, this._loginUseCase);

//   Future<void> register({
//     required String email,
//     required String password,
//     required String name,
//     required String phoneNumber,
//   }) async {
//     try {
//       loading.value = true;
//       errorMessage.value = null;

//       final registeredUser = await _registerUseCase.execute(
//         email: email,
//         password: password,
//         name: name,
//         phoneNumber: phoneNumber,
//       );

//       user.value = registeredUser;
//       Get.offAllNamed('/home');
//     } on ApiException catch (e) {
//       errorMessage.value = e.message;
//     } finally {
//       loading.value = false;
//     }
//   }

//   Future<void> login({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       loading.value = true;
//       errorMessage.value = null;

//       final loggedInUser = await _loginUseCase.execute(email, password);

//       user.value = loggedInUser;
//       Get.offAllNamed('/home');
//     } on ApiException catch (e) {
//       errorMessage.value = e.message;
//     } finally {
//       loading.value = false;
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel/core/exceptions/api_exception.dart';
import 'package:travel/domains/entities/user.dart';
import 'package:travel/domains/usecases/auth/login_usecase.dart';
import 'package:travel/domains/usecases/auth/register_usecase.dart';

class AuthController extends GetxController {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;

  // Controllers for text fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  // Observable variables
  final isLoading = false.obs;
  final user = Rxn<User>();
  final errorMessage = RxnString();
  final rememberMe = false.obs;
  final isPasswordVisible = false.obs;

  AuthController(this._registerUseCase, this._loginUseCase);

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> _loadSavedCredentials() async {
    // Implement loading saved credentials if remember me was checked
  }

  Future<void> _saveCredentials() async {
    // Implement saving credentials if remember me is checked
  }

  bool validateLoginInputs() {
    if (emailController.text.isEmpty || !GetUtils.isEmail(emailController.text)) {
      errorMessage.value = 'Please enter a valid email';
      return false;
    }
    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      errorMessage.value = 'Password must be at least 6 characters';
      return false;
    }
    return true;
  }

  Future<void> login() async {
    if (!validateLoginInputs()) return;

    try {
      isLoading.value = true;
      errorMessage.value = null;

      final loggedInUser = await _loginUseCase.execute(
        emailController.text.trim(),
        passwordController.text,
      );

      if (rememberMe.value) {
        await _saveCredentials();
      }

      user.value = loggedInUser;
      Get.offAllNamed('/home');
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar(
        'Error',
        e.message ?? 'An error occurred', // Added null check with default message
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      final registeredUser = await _registerUseCase.execute(
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
      );

      user.value = registeredUser;
      Get.offAllNamed('/home');
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar(
        'Error',
        e.message ?? 'Registration failed', // Added null check with default message
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}