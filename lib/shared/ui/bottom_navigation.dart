import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:travel/core/controllers/navigation_controller.dart';

class BottomNavigation extends GetView<NavigationController> {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => StylishBottomBar(
        backgroundColor: Colors.blue.shade900,
        gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade900]),
        option: AnimatedBarOptions(
          iconSize: 32,
          iconStyle: IconStyle.Default,
          barAnimation: BarAnimation.blink,
          opacity: 0.3,
          padding: const EdgeInsets.only(top: 10),
        ),
        items: [
          BottomBarItem(
            icon: const Icon(
              LucideIcons.home,
              size: 28,
            ),
            selectedIcon: const Icon(
              LucideIcons.home,
              size: 28,
            ),
            selectedColor: Colors.white30,
            unSelectedColor: Colors.white,
            title: const Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          BottomBarItem(
            icon: const Icon(
              LucideIcons.compass,
              size: 28,
            ),
            selectedIcon: const Icon(
              LucideIcons.compass,
              size: 28,
            ),
            selectedColor: Colors.white30,
            unSelectedColor: Colors.white,
            title: const Text(
              'Explore',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          BottomBarItem(
            icon: const Icon(
              LucideIcons.ticket,
              size: 28,
            ),
            selectedIcon: const Icon(
              LucideIcons.ticket,
              size: 28,
            ),
            selectedColor: Colors.white30,
            unSelectedColor: Colors.white,
            title: const Text(
              'My tickets',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          BottomBarItem(
            icon: const Icon(
              LucideIcons.user,
              size: 28,
            ),
            selectedIcon: const Icon(
              LucideIcons.user,
              size: 28,
            ),
            selectedColor: Colors.white30,
            unSelectedColor: Colors.white,
            title: const Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
        hasNotch: true,
        // fabLocation: StylishBarFabLocation.values,
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changePage,
      ),
    );
  }
}
