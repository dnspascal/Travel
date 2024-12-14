import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:travel/routes/routes.dart';
import 'package:travel/modules/auth/shared/social_login.dart';
import 'package:travel/modules/auth/controllers/login_controller.dart';
import 'package:travel/modules/auth/shared/custom_text_field.dart';

class LoginView extends GetView<LoginController> {
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
                    'Sign In',
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
              if (true)
                _wrongCredentials(controller.errorMessage, controller.isError),
              CustomTextField(
                controller: controller.emailController,
                label: 'Email',
                hint: 'Enter your email',
                prefixIcon: Icons.email_outlined,
                onChanged: (value) => controller.emailErrorMessage.value = '',
              ),
              Obx(() {
                if (controller.emailErrorMessage.value.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      controller.emailErrorMessage.value,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
              const SizedBox(height: 16),
              CustomTextField(
                controller: controller.passwordController,
                label: 'Password',
                hint: 'Enter your password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                onChanged: (value) =>
                    controller.passwordErrorMessage.value = '',
              ),
              Obx(() {
                if (controller.passwordErrorMessage.value.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      controller.passwordErrorMessage.value,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
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
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 16),
                    ),
                    onPressed:
                        controller.isLoading.value ? null : controller.login,
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1,
                            ))
                        : const Text(
                            'Sign In',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18.0,
                                color: Colors.white),
                          ),
                  )),
              const SizedBox(height: 24),
              const SocialLoginSection(),
              const SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: () => Get.toNamed(Routes.register),
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.bodySmall,
                      children: [
                        const TextSpan(text: '  '),
                        TextSpan(
                          text: 'Sign up',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Colors.blue.shade500,
                                  fontWeight: FontWeight.w900),
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

Widget _wrongCredentials(message, show) {
  return Obx(() => Visibility(
        visible: show.value,
        child: Material(
          elevation: 0.0,
          color: Colors.red.shade600,
          borderRadius: BorderRadius.circular(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Obx(() => Text(
                      message.value,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    )).paddingOnly(left: 10),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => {},
              ),
            ],
          ).paddingSymmetric(vertical: 0.0, horizontal: 12.0),
        ).marginOnly(bottom: 16.0),
      ));
}
