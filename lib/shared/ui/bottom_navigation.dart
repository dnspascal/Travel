import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:travel/core/controllers/navigation_controller.dart';

class BottomNavigation extends GetView<NavigationController> {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => StylishBottomBar(
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
              Icons.explore_outlined,
              size: 28,
            ),
            selectedIcon: const Icon(
              Icons.explore,
              size: 28,
            ),
            selectedColor: Colors.white30,
            unSelectedColor: Colors.white,
            title: const Text(
              'Explore',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          // BottomBarItem(
          //   icon: const Icon(
          //     Icons.home_outlined,
          //     size: 28,
          //   ),
          //   selectedIcon: const Icon(
          //     Icons.home,
          //     size: 28,
          //   ),
          //   selectedColor: Colors.white30,
          //   unSelectedColor: Colors.white,
          //   title: const Text(
          //     'Home',
          //     style: TextStyle(fontWeight: FontWeight.w900),
          //   ),
          // ),
          BottomBarItem(
            icon: const Icon(
              Icons.settings_outlined,
              size: 28,
            ),
            selectedIcon: const Icon(
              Icons.settings,
              size: 28,
            ),
            selectedColor: Colors.white30,
            unSelectedColor: Colors.white,
            title: const Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
        backgroundColor: Colors.blue,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
        hasNotch: true,
        // fabLocation: StylishBarFabLocation.values,
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changePage,
      ),
    );
  }
}
