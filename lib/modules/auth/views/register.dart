import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel/modules/auth/shared/custom_field.dart';
import 'package:travel/modules/auth/shared/registration/social.dart';
import 'package:travel/modules/auth/controllers/register_controller.dart';

class RegistrationView extends GetView<MultiStepRegistrationController> {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: SafeArea(
          child: _buildRegistrationContent(context, pageController),
        ),
      ),
    );
  }

  Widget _buildRegistrationContent(
      BuildContext context, PageController pageController) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          Obx(() => _buildProgressIndicator(context)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildFirstStep(context),
                _buildSecondStep(context),
                _buildThirdStep(context),
              ],
            ),
          ).marginOnly(top: 50),
          Obx(() => _buildNavigationButtons(pageController, context)),
          const SocialRegistration()
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(
              LucideIcons.chevronLeft,
            ),
            onPressed: () => Get.back(),
          ),
          const Gap(20),
          Row(
            children: [
              Text(
                'Create Your Account',
                style: GoogleFonts.quicksand(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const Text(' 👋'),
            ],
          )
        ]).paddingSymmetric(horizontal: 24, vertical: 16);
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: _buildFadingDivider(
              isActive: controller.currentStep > 0,
              isLeft: true,
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: controller.currentStep >= 0
                    ? [
                        Colors.blueAccent.shade100,
                        Colors.blue.shade900,
                      ]
                    : [
                        Colors.grey.shade300,
                        Colors.grey.shade200,
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                '${controller.currentStep + 1}/3',
                style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: _buildFadingDivider(
              isActive: controller.currentStep > 0,
              isLeft: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstStep(BuildContext context) {
    return Form(
      key: controller.firstStepKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Details',
            style: GoogleFonts.quicksand(
              fontSize: 24,
            ),
          ),
          const Gap(20),
          CustomTextField(
            controller: controller.firstNameController,
            label: 'First Name',
            hint: 'Enter your first name',
            validator: controller.validateFirstName,
            icon: LucideIcons.user,
            focusNode: controller.firstNameFocusNode,
            focusState: controller.firstNameFocused,
             onChanged: (value) {
                   controller.firstStepKey.currentState?.validate();
                },
          ),
          const Gap( 16),
          CustomTextField(
            controller: controller.lastNameController,
            label: 'Last Name',
            hint: 'Enter your last name',
            validator: controller.validateLastName,
            icon: LucideIcons.user,
            focusNode: controller.secondNameFocusNode,
            focusState: controller.secondNameFocused,
               onChanged: (value) {
                   controller.firstStepKey.currentState?.validate();
                },
          ),
        ],
      ),
    );
  }

  Widget _buildSecondStep(BuildContext context) {
    return Form(
      key: controller.secondStepKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: GoogleFonts.quicksand(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: controller.emailController,
            label: 'Email',
            hint: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            validator: controller.validateEmail,
            icon: Icons.email_outlined,
            focusNode: controller.emailFocusNode,
            focusState: controller.emailFocused,
            onChanged: (value) {
                   controller.secondStepKey.currentState?.validate();
                },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: controller.phoneController,
            label: 'Phone Number',
            hint: 'Enter your phone number',
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(9),
            ],
            validator: controller.validatePhone,
            icon: Icons.phone_outlined,
            focusNode: controller.phoneFocusNode,
            focusState: controller.phoneFocused,
             onChanged: (value) {
                   controller.secondStepKey.currentState?.validate();
                },
            
          ),
        ],
      ),
    );
  }

  Widget _buildThirdStep(BuildContext context) {
    return Form(
      key: controller.thirdStepKey,
      child: ListView(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          Text(
            'Secure Your Account',
            style: GoogleFonts.quicksand(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: controller.passwordController,
            label: 'Password',
            hint: 'Create a strong password',
            isPassword: true,
            validator: controller.validatePassword,
            icon: Icons.lock_outline,
            focusNode: controller.passwordFocusNode,
            focusState: controller.passwordFocused,
             onChanged: (value) {
                   controller.thirdStepKey.currentState?.validate();
                },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: controller.confirmPasswordController,
            label: 'Confirm Password',
            hint: 'Repeat your password',
            isPassword: true,
            validator: controller.validateConfirmPassword,
            icon: Icons.lock_outline,
            focusNode: controller.confirmPasswordFocusNode,
            focusState: controller.confirmPasswordFocused,
             onChanged: (value) {
                   controller.thirdStepKey.currentState?.validate();
                },
          ),
          const SizedBox(height: 16),
          Obx(() => controller.registrationError.value
              ? _errorMessage(controller.errorMessage.value)
              : const SizedBox.shrink()),
          Row(
            children: [
              Obx(() => Checkbox(
                    value: controller.isTermsAccepted,
                    onChanged: (bool? value) {
                      if (value != null) {
                        controller.toggleTermsAcceptance(value);
                      }
                    },
                    activeColor: const Color(0xFF4169E1),
                  )),
              Text(
                'I accept the Terms of Service and Privacy Policy',
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                ),
              ),
             
            ],
          ),
          
   
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(
      PageController pageController, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous Button
          Obx(() => controller.currentStep > 0
              ? ElevatedButton(
                  onPressed: () => controller.previousStep(pageController),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent.shade700,
                    side: BorderSide(
                      color: Colors.blueAccent.shade700,
                      width: 0.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(LucideIcons.chevronLeft),
                      const Gap(8),
                      Text(
                        'Previous',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink()),

          ElevatedButton(
            onPressed: () {
              if (controller.currentStep == 2) {
                controller.submitRegistration();
              } else {
                controller.nextStep(pageController);
              }
            },
            style: ElevatedButton.styleFrom(
              //fixedSize: const Size(150, 50),
              backgroundColor: Colors.blueAccent.shade700,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
            child: controller.isLoading.value
                ? const SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1,
                    ))
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (controller.currentStep == 2)
                        const Icon(LucideIcons.checkCircle, size: 18),
                      const Gap(8),
                      Text(
                        controller.currentStep == 2 ? 'Submit' : 'Next',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Gap(8),
                      if (controller.currentStep < 2)
                        const Icon(
                          LucideIcons.chevronRight,
                          // size: 18,
                        )
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFadingDivider({required bool isActive, required bool isLeft}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          painter: FadingDividerPainter(
            isActive: isActive,
            isLeft: isLeft,
          ),
          child: SizedBox(
            height: 3,
            width: constraints.maxWidth,
          ),
        );
      },
    );
  }
}

class FadingDividerPainter extends CustomPainter {
  final bool isActive;
  final bool isLeft;

  FadingDividerPainter({
    required this.isActive,
    required this.isLeft,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.blueAccent.shade700,
          Colors.blueAccent.shade700.withOpacity(0),
        ],
        stops: const [0.3, 1.0],
        begin: isLeft ? Alignment.centerLeft : Alignment.centerRight,
        end: isLeft ? Alignment.centerRight : Alignment.centerLeft,
      ).createShader(
          Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));

    canvas.drawLine(
      Offset.zero,
      Offset(size.width, 0),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

Widget _errorMessage(e) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.red.shade500,
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.red.shade100.withOpacity(0.5),
          blurRadius: 10,
          offset: const Offset(0, 4),
        )
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: Colors.red.shade600,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            e,
            style: TextStyle(
              color: Colors.red.shade800,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
