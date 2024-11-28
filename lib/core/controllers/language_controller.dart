// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:travel/core/services/language.dart';

// class LanguageController extends GetxController {
//   final Rx<Locale> _selectedLocale = Rx(LanguageService.getCurrentLocale());

//   Locale get selectedLocale => _selectedLocale.value;

//   void changeLanguage(Locale locale) async {
//     await LanguageService.setLocale(locale);
//     _selectedLocale.value = locale;
//   }

//   List<Locale> get supportedLocales => LanguageService.supportedLocales;

//   String getLanguageName(Locale locale) {
//     switch (locale.languageCode) {
//       case 'en':
//         return 'English';
//       case 'sw':
//         return 'Swahili';
//       default:
//         return 'Unknown';
//     }
//   }
// }
