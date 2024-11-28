import 'package:get/get.dart';
import 'package:travel/core/bindings/auth_binding.dart';
import 'package:travel/modules/auth/views/login_view.dart';
import 'package:travel/routes/routes.dart';
import 'package:travel/shared/ui/homepage_view.dart';
import 'package:travel/shared/layout/layout.dart';

class Pages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => Layout(child: Home()),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
  ];
}
