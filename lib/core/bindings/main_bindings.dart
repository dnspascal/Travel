import 'package:get/get.dart';
import 'package:travel/core/services/storage.dart';
import 'package:travel/core/controllers/home_controller.dart';
import 'package:travel/modules/locale/controllers/locale_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travel/core/controllers/navigation_controller.dart';
import 'package:travel/modules/network/controllers/network_controllers.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocaleController(), permanent: true);
    Get.put(NavigationController(), permanent: true);
    Get.put(HomeController());

    Get.lazyPut(() => const FlutterSecureStorage());

    // Core services
    Get.put(StorageService(Get.find()), permanent: true);

    Get.put(NetworkController());
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
