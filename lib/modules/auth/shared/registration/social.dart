import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travel/routes/routes.dart';

class SocialRegistration extends StatelessWidget {
  const SocialRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        children: [
          _buildDividerWithText('Sign up with Social Media', context),
          const Gap(20),
          _buildSocialButtons(context),
          const Gap(20),
          _buildSignInRow(context),
        ],
      ),
    );
  }

  Widget _buildDividerWithText(String text, BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialButton(
          iconPath: 'assets/icons/svg/apple.svg',
          backgroundColor: Colors.black87,
          iconColor: Colors.white,
          onTap: () => print('Apple Sign In'),
        ),
        const Gap(20),
        _socialButton(
          iconPath: 'assets/icons/svg/google.svg',
          backgroundColor: Colors.white,
          onTap: () => print('Google Sign In'),
        ),
        const Gap(20),
        _socialButton(
          iconPath: 'assets/icons/svg/facebook.svg',
          onTap: () => print('Facebook Sign In'),
        ),
      ],
    );
  }

  Widget _buildSignInRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.login),
          child: Text(
            'Sign In',
            style: TextStyle(
              color: Colors.blue.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ).marginOnly(left: 8),
      ],
    );
  }

  Widget _socialButton({
    required String iconPath,
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SvgPicture.asset(
          iconPath,
          height: 22,
          width: 22,
          colorFilter: iconColor != null
              ? ColorFilter.mode(iconColor, BlendMode.srcIn)
              : null,
        ),
      ),
    );
  }
}
