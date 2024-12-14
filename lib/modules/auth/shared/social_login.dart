import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel/modules/auth/shared/social_button.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'or continue with',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(
              onTap: () {},
              iconPath: 'assets/icons/svg/google.svg',
            ),
            const SizedBox(width: 16),
            if (Platform.isIOS)
              SocialButton(
                onTap: () {},
                iconPath: 'assets/icons/svg/apple.svg',
              ),
            const SizedBox(width: 16),
            SocialButton(
              onTap: () {},
              iconPath: 'assets/icons/svg/facebook.svg',
            ),
          ],
        ),
      ],
    );
  }
}
