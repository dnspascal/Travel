import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:travel/modules/locale/controllers/locale_controller.dart';
import 'package:travel/modules/locale/shared/initial_lang.dart';

class SplashScreen extends GetWidget<LocaleController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: Future.delayed(const Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (controller.shouldShowLanguageSelection()) {
                  Get.bottomSheet(
                    const LanguageBottomSheet(),
                    isDismissible: false,
                    enableDrag: false,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                  );
                } else {
                  Get.offAll(() => Container(
                        color: Colors.white,
                        child: const Text("DENIS MGAYA"),
                      ));
                }
              });
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
