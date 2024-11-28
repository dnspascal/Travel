import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TravelBar extends StatelessWidget implements PreferredSizeWidget {
  const TravelBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(

      automaticallyImplyLeading: false,
      elevation: 30.0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(

        color: Colors.white,
        // decoration: const BoxDecoration(

        //   gradient: LinearGradient(
        //     begin: Alignment.centerLeft,
        //     end: Alignment.centerRight,
        //     colors: [
        //       Color(0xFF2563EB), // Blue 600
        //       Color(0xFF9333EA), // Purple 600
        //     ],
        //   ),
        // ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Iconsax.menu,
            color: Colors.black,
          ),
          const Text(
            'Travel',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Iconsax.notification,
                color: Colors.black,
              ),
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
