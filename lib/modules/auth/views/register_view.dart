import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:travel/modules/auth/controllers/auth_controller.dart';
import 'package:travel/modules/auth/shared/custom_text_field.dart';
import 'package:travel/routes/routes.dart';
import 'package:travel/shared/loaders/spinner.dart';

class SignUpView extends GetView<AuthController> {
  SignUpView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // final _obscurePassword = true.obs;
  final _acceptTerms = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButton(),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Text(
                      'Create an account',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const Text(' 👋'),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Welcome! Please enter your details.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 24.0),
                CustomTextField(
                  controller: controller.firstController,
                  label: 'First Name',
                  hint: 'Enter your First Name',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: controller.secondController,
                  label: 'Second Name',
                  hint: 'Enter your Second Name',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your second name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  hint: 'Enter your Email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !GetUtils.isEmail(value)) {
                      return 'Please enter valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: controller.phoneController,
                  label: 'Phone Number',
                  hint: 'Enter your Phone Number',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  prefix: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.phone, color: Colors.grey[600], size: 20),
                        const SizedBox(width: 12),
                        const Text(
                          '+255 ',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.length != 9) {
                      return 'Phone number must be 9 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: '••••••••',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  hint: '••••••••',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Obx(() => Row(
                      children: [
                        Checkbox(
                          value: _acceptTerms.value,
                          onChanged: (value) =>
                              _acceptTerms.value = value ?? false,
                          activeColor: Theme.of(context).primaryColor,
                        ),
                        const Text('I accept the terms and conditions'),
                      ],
                    )),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (!_acceptTerms.value) {
                          Get.snackbar(
                            'Error',
                            'Please accept the terms and conditions',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }
                        final phoneNumber =
                            '255${controller.phoneController.text}';

                        controller.register(
                          email: controller.emailController.text,
                          password: _passwordController.text,
                          firstName: controller.firstController.text,
                          secondName: controller.secondController.text,
                          phoneNumber: phoneNumber,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Obx(() {
                      return controller.isLoading.value
                          ? const LoadingState()
                          : const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w900),
                            );
                    }),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or sign up with',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[300])),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton('assets/icons/svg/apple.svg'),
                    const SizedBox(
                      width: 20.0,
                    ),
                    _buildSocialButton('assets/icons/svg/google.svg'),
                    const SizedBox(
                      width: 20.0,
                    ),
                    _buildSocialButton('assets/icons/svg/facebook.svg'),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.login);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String iconPath) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SvgPicture.asset(
        iconPath,
        height: 24,
        width: 24,
      ),
    );
  }
}
