import 'package:get/get.dart';
import 'package:travel/modules/network/controllers/network_controllers.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkController());
  }
}
