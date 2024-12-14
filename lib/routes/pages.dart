import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:travel/modules/auth/views/register.dart';
import 'package:travel/routes/routes.dart';
import 'package:travel/shared/layout/layout.dart';
import 'package:travel/modules/home/views/home.dart';
import 'package:travel/core/bindings/user_binding.dart';
import 'package:travel/core/bindings/auth_binding.dart';
import 'package:travel/modules/profile/views/profile.dart';
import 'package:travel/modules/auth/views/register_view.dart';

class Pages {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const RegistrationView(),
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
      name: Routes.profile,
      page: () => const Layout(child: BusTicketProfile()),
      binding: UserBinding(),
    ),
    GetPage(
      name: Routes.explore,
      page: () => const Layout(
          child: Center(
        child: Text("EXPLORE MORE HERE"),
      )),
      binding: UserBinding(),
    ),
    GetPage(
      name: Routes.tickets,
      page: () => const Layout(
          child: Center(
        child: Text("THESE ARE MY TICKETS"),
      )),
      binding: UserBinding(),
    ),
  ];
}
