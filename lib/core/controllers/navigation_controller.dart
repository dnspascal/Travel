import 'package:get/get.dart';
import 'package:travel/routes/routes.dart';

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxBool isFavorite = false.obs;

  void changePage(int index) {
    if (index == selectedIndex.value) return;
    selectedIndex.value = index;

    switch (index) {
      case 0:
        Get.offNamed(Routes.initial);
        break;
      case 1:
        // Get.offNamed(Routes.home);
        break;
      case 2:
        // Get.offNamed(Routes.settings);
        break;
    }
  }

  void goToHome() {
    selectedIndex.value = 1;
    // Get.offNamed(Routes.home);
  }
}
