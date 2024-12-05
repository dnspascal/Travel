import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel/core/exceptions/api_exception.dart';
import 'package:travel/domains/usecases/auth/login_usecase.dart';
import 'package:travel/routes/routes.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final errorMessage = RxnString();
  final rememberMe = false.obs;

  LoginController(this._loginUseCase);

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> _loadSavedCredentials() async {
    // Implement loading saved credentials if remember me was checked
  }

  Future<void> _saveCredentials() async {
    // Implement saving credentials if remember me is checked
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool validateLoginInputs() {
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
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
    // Get.toNamed(Routes.home);
    if (!validateLoginInputs()) return;
    debugPrint("PRINT SOMETHING HERE");

    debugPrint(passwordController.text + emailController.text);

    try {
      isLoading.value = true;
      errorMessage.value = null;

      // final loggedInUser = await _loginUseCase.execute(
      //   emailController.text.trim(),
      //   passwordController.text,
      // );

      if (rememberMe.value) {
        await _saveCredentials();
      }

      // user.value = loggedInUser;
      Get.offAllNamed('/home');
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar(
        'Error',
        e.message ??
            'An error occurred', // Added null check with default message
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
