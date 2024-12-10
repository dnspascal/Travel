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
        Get.offNamed(Routes.home);
        break;
      case 1:
        Get.offNamed(Routes.explore);
        break;
      case 2:
        Get.offNamed(Routes.tickets);
        break;
      case 3:
        Get.offNamed(Routes.profile);
        break;
    }
  }

  void goToHome() {
    selectedIndex.value = 1;
    // Get.offNamed(Routes.home);
  }
}
