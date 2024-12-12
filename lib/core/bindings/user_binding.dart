import 'package:get/get.dart';
import 'package:travel/modules/profile/controllers/profile_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController(Get.find()));
  }
}