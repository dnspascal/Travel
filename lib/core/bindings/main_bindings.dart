import 'package:get/get.dart';
import 'package:travel/core/controllers/home_controller.dart';
import 'package:travel/core/controllers/locale_controller.dart';
import 'package:travel/core/controllers/navigation_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocaleController(), permanent: true);
    Get.put(NavigationController(), permanent: true);
    Get.put(HomeController());

    // Core services
    // Get.put(ApiService(), permanent: true);
    // Get.put(LocalStorage(), permanent: true);
    // Get.put(ConnectivityService(), permanent: true);

    // // Repositories
    // Get.put(HomeRepository(
    //   Get.find<ApiService>(),
    //   Get.find<LocalStorage>(),
    // ));
  }
}
