import 'package:get/get.dart';
import 'package:travel/core/bindings/user_binding.dart';
import 'package:travel/modules/profile/views/profile.dart';
import 'package:travel/routes/routes.dart';
import 'package:travel/shared/layout/layout.dart';
import 'package:travel/modules/home/views/home.dart';
import 'package:travel/core/bindings/auth_binding.dart';
import 'package:travel/modules/auth/views/login_view.dart';
import 'package:travel/modules/auth/views/register_view.dart';

class Pages {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => SignUpView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => Layout(child: Home()),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () =>  BusTicketProfile(),
      binding: UserBinding(),
    ),
  ];
}
