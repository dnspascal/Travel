import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel/modules/auth/shared/custom_text_field.dart';
import 'package:travel/modules/auth/shared/social_login.dart';
import 'package:travel/routes/pages.dart';
import 'package:travel/routes/routes.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(
                onPressed: () => Get.back(),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    'Log in',
                    style: Get.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(' 👋'),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Welcome back! Please enter your details.',
                style: Get.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: controller.emailController,
                label: 'Email',
                hint: 'Enter your email',
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 16),
              // Obx(() =>
              CustomTextField(
                controller: controller.passwordController,
                label: 'Password',
                hint: '••••••••',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                // )
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) =>
                            controller.rememberMe.value = value ?? false,
                        activeColor: Get.theme.primaryColor,
                      )),
                  const Text('Remember for 30 days'),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot password',
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          controller.isLoading.value ? null : controller.login,
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Sign In'),
                    ),
                  )),
              const SizedBox(height: 24),
              const SocialLoginSection(),
              const SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: () => Get.toNamed(Routes.initial),
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: Colors.grey[600]),
                      children: [
                        const TextSpan(text: '  '),
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                            color: Get.theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
