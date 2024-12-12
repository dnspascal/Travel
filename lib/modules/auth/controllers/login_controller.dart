import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:travel/core/exceptions/api_exception.dart';
import 'package:travel/core/services/storage.dart';
import 'package:travel/domains/usecases/auth/login_usecase.dart';
import 'package:travel/domains/usecases/user/use_usecase.dart';
import 'package:travel/routes/routes.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase;
  final UserUsecase _getUserUseCase;
  final StorageService _storageService;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  var emailErrorMessage = ''.obs;
  var passwordErrorMessage = ''.obs;
  var errorMessage = ''.obs;
  final rememberMe = false.obs;

  LoginController(
      this._loginUseCase, this._getUserUseCase, this._storageService);

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
    bool isValid = true;

    if (emailController.text.isEmpty) {
      emailErrorMessage.value = 'Please this field is required';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailErrorMessage.value = 'Please enter a valid email';
      isValid = false;
    } else {
      emailErrorMessage.value = '';
    }

    if (passwordController.text.isEmpty) {
      passwordErrorMessage.value = 'Please this field is required';
      isValid = false;
    } else if (passwordController.text.length < 6) {
      passwordErrorMessage.value = 'Password must be at least 8 characters';
      isValid = false;
    } else {
      passwordErrorMessage.value = '';
    }

    return isValid;
  }

  Future<void> login() async {
    if (!validateLoginInputs()) return;

    try {
      isLoading.value = true;
      errorMessage.value = "";

      await _loginUseCase.execute(
        emailController.text.trim(),
        passwordController.text,
      );

      if (rememberMe.value) {
        await _saveCredentials();
      }

      final userDetails = await _getUserUseCase.call();
      await _storageService.write("user-details", jsonEncode(userDetails));

      Get.offAllNamed(Routes.home);
    } on ApiException catch (e, stackTrace) {
      errorMessage.value = e.message ?? '';

      print(e.message);
      print(stackTrace);
      print("Response status code: ${e.statusCode}");
      print("Response body: ${e.responseBody}");

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('An Error Occurred! 😞'),
          duration: Duration(seconds: 30),
          backgroundColor: Colors.redAccent,
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      print("ANY OTHER EXCEPTION");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
