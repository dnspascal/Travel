import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel/core/controllers/navigation_controller.dart';
import 'package:travel/shared/ui/app_bar.dart';

class Layout extends GetView<NavigationController> {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TravelBar(),
      body: SafeArea(child: child),
      // bottomNavigationBar: const BottomNavigation(),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToHome,
        backgroundColor: Colors.white,
        child:  Icon(
          Iconsax.message_text4,
          color: Colors.blue.shade700,
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
