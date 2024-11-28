import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final String iconPath;

  const SocialButton({
    super.key,
    required this.onTap,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SvgPicture.asset(
          iconPath,
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}