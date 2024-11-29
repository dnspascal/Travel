// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:travel/core/controllers/locale_controller.dart';

// class TravelBar extends StatelessWidget implements PreferredSizeWidget {
//   const TravelBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       elevation: 30.0,
//       backgroundColor: Colors.transparent,
//       flexibleSpace: Container(
//         color: Colors.white,
//       ),
//       title: Row(
//         children: [
//           Image.asset(
//             'assets/icons/app/app-icon.png',
//             width: 20.0,
//           ),
//           const SizedBox(
//             width: 8.0,
//           ),
//           const Text(
//             'Travel',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.w900,
//             ),
//           ),
//         ],
//       ),
//       actions: [
//         ElevatedButton(
//           onPressed: () {
//             Get.find<LocaleController>().changeLanguage('sw');
//           },
//           child: const Text('switch'),
//         ),
//         Stack(
//           clipBehavior: Clip.none,
//           children: [
//             const Icon(
//               Iconsax.notification,
//               color: Colors.black,
//             ),
//             Positioned(
//               top: -4,
//               right: -4,
//               child: Container(
//                 width: 12,
//                 height: 12,
//                 decoration: const BoxDecoration(
//                   color: Colors.red,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel/core/controllers/locale_controller.dart';

class TravelBar extends StatelessWidget implements PreferredSizeWidget {
  TravelBar({super.key});
  final localeController = Get.find<LocaleController>();

  @override
  Widget build(BuildContext context) {
    return Obx((){
        return AppBar(
          automaticallyImplyLeading: false,
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Image.asset(
                'assets/icons/app/app-icon.png',
                width: 30.0,
              ),
              const SizedBox(width: 12.0),
              const Text(
                'Travel',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  String newLang =
                      localeController.languageCode.value == 'en' ? 'sw' : 'en';
                  localeController.changeLanguage(newLang);
                },
                child: Container(
                  width: 70,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: localeController.languageCode.value == 'en'
                        ? Colors.blue.shade100
                        : Colors.blue.shade300,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        left: localeController.languageCode.value == 'en'
                            ? 5
                            : 35,
                        top: 3,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'EN',
                              style: TextStyle(
                                color:
                                    localeController.languageCode.value == 'en'
                                        ? Colors.blue.shade900
                                        : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'SW',
                              style: TextStyle(
                                color:
                                    localeController.languageCode.value == 'sw'
                                        ? Colors.blue.shade900
                                        : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Notification Icon
            Stack(
              clipBehavior: Clip.none,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Iconsax.notification,
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  top: -4,
                  right: 6,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
