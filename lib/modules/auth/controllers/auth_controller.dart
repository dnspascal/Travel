import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel/core/exceptions/api_exception.dart';
import 'package:travel/domains/entities/user.dart';
import 'package:travel/domains/usecases/auth/register_usecase.dart';

class AuthController extends GetxController {
  final RegisterUseCase _registerUseCase;

  // Controllers for text fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstController = TextEditingController();
  final secondController = TextEditingController();
  final phoneController = TextEditingController();

  // Observable variables
  final isLoading = false.obs;
  final user = Rxn<User>();
  final errorMessage = RxnString();
  final isPasswordVisible = false.obs;

  AuthController(this._registerUseCase);

  @override
  void onInit() {
    super.onInit();
    // _loadSavedCredentials();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    firstController.dispose();
    secondController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

 
  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String secondName,
    required String phoneNumber,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      final registeredUser = await _registerUseCase.execute(
        email: email,
        password: password,
        firstName: firstName,
        secondName: secondName,
        phoneNumber: phoneNumber,
      );

      user.value = registeredUser;
      Get.offAllNamed('/home');
    } on ApiException catch (e) {
      errorMessage.value = e.message;
     SnackBar customSnackBar(String message) {
  return SnackBar(
    content: Container(
      height: 50, // Fixed height
      alignment: Alignment.center, // Center-align content
      child: Text(
        message,
        maxLines: 1, // Restrict to one line
        overflow: TextOverflow.ellipsis, // Truncate with ellipsis
        textAlign: TextAlign.center, // Center-align text within the snackbar
        style: const TextStyle(fontSize: 14.0, color: Colors.white),
      ),
    ),
    behavior: SnackBarBehavior.floating, // Floating style
    backgroundColor: Colors.red, // Background color
    margin: const EdgeInsets.all(15.0), // Margin for floating snackbar
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), // Rounded corners
    duration: const Duration(seconds: 3), // Visible duration
    action: SnackBarAction(
      label: 'Action',
      textColor: Colors.white, // Action button color
      onPressed: () {
        // Action code
      },
    ),
  );
}

    } finally {
      isLoading.value = false;
    }
  }
}
