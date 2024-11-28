// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AuthMiddleware extends GetMiddleware {
//   final authService = Get.find<AuthService>();

//   @override
//   RouteSettings? redirect(String? route) {
//     return authService.isAuthenticated() 
//       ? null 
//       : const RouteSettings(name: '/login');
//   }
// }