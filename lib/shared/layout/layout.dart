import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:travel/core/controllers/navigation_controller.dart';
import 'package:travel/shared/ui/app_bar.dart';
import 'package:travel/shared/ui/bottom_navigation.dart';

class Layout extends GetView<NavigationController> {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TravelBar(),
      body: SafeArea(child: Container(child: child)),
      bottomNavigationBar: const BottomNavigation(),
      extendBody: true,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToHome,
        backgroundColor: Colors.blue.shade900,
        child: const Icon(
          LucideIcons.loader,
          color: Colors.white,
        ),
      ),
    );
  }
}
