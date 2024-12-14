import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiStepRegistrationController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final firstStepKey = GlobalKey<FormState>();
  final secondStepKey = GlobalKey<FormState>();
  final thirdStepKey = GlobalKey<FormState>();

  final _currentStep = 0.obs;
  int get currentStep => _currentStep.value;

  final _isTermsAccepted = false.obs;
  bool get isTermsAccepted => _isTermsAccepted.value;

  RxBool firstNameFocused = false.obs;
  RxBool secondNameFocused = false.obs;
  RxBool emailFocused = false.obs;
  RxBool phoneFocused = false.obs;
  RxBool passwordFocused = false.obs;
  RxBool confirmPasswordFocused = false.obs;

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode secondNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();

    firstNameFocusNode.addListener(() {
      firstNameFocused.value = firstNameFocusNode.hasFocus;
    });
    secondNameFocusNode.addListener(() {
      secondNameFocused.value = secondNameFocusNode.hasFocus;
    });
    emailFocusNode.addListener(() {
      emailFocused.value = emailFocusNode.hasFocus;
    });
    phoneFocusNode.addListener(() {
      phoneFocused.value = phoneFocusNode.hasFocus;
    });
    passwordFocusNode.addListener(() {
      passwordFocused.value = passwordFocusNode.hasFocus;
    });
    confirmPasswordFocusNode.addListener(() {
      confirmPasswordFocused.value = confirmPasswordFocusNode.hasFocus;
    });
  }

  void toggleTermsAcceptance(bool value) {
    _isTermsAccepted.value = value;
  }

  void nextStep(PageController pageController) {
    switch (currentStep) {
      case 0:
        if (firstStepKey.currentState?.validate() ?? false) {
          _currentStep.value++;
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
        break;
      case 1:
        if (secondStepKey.currentState?.validate() ?? false) {
          _currentStep.value++;
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
        break;
    }
  }

  void previousStep(PageController pageController) {
    if (currentStep > 0) {
      _currentStep.value--;
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void submitRegistration() {
    if (thirdStepKey.currentState?.validate() ?? false) {
      if (!isTermsAccepted) {
        Get.snackbar(
          'Terms Required',
          'Please accept the Terms of Service',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
        );
        return;
      }

      // Perform registration logic here
      Get.snackbar(
        'Success',
        'Registration Completed Successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
      );
    }
  }

  // Validation Methods
  String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your first name';
    }
    if (value.trim().length < 2) {
      return 'First name must be at least 2 characters';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your last name';
    }
    if (value.trim().length < 2) {
      return 'Last name must be at least 2 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an email address';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 9) {
      return 'Phone number must be 9 digits';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    firstNameFocusNode.dispose();
    secondNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.onClose();
  }
}
