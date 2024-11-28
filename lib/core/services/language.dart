// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:travel/core/constants/languages.dart';
// import 'package:travel/core/constants/storage.dart';
// import 'package:travel/core/services/storage.dart';

// class LanguageService {
//   static Locale getCurrentLocale() {
//     final storedLanguage =
//         StorageService.read<String>(StorageConstants.languageKey);

//     if (storedLanguage != null) {
//       return Locale(storedLanguage);
//     }

//     return AppConstants.defaultLocale;
//   }

//   static Future<void> setLocale(Locale locale) async {
//     await StorageService.write(
//         StorageConstants.languageKey, locale.languageCode);

//     // Update app locale
//     await Get.updateLocale(locale);
//   }

//   static List<Locale> get supportedLocales => AppConstants.supportedLocales;
// }
