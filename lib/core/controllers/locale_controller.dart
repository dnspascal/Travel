import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleController extends GetxController {
  final GetStorage _storage = GetStorage();
  final _key = 'selected_lang';

  var languageCode = 'sw'.obs;

  @override
  void onInit() {
    super.onInit();
    final storedLang = _storage.read(_key);
    if (storedLang != null) {
      languageCode.value = storedLang;
      Get.updateLocale(Locale(storedLang));
    } else {
      Get.updateLocale(Locale(languageCode.value));
    }
  }

  void changeLanguage(String lang) {
    if (lang != languageCode.value) {
      languageCode.value = lang;
      _storage.write(_key, lang);
      Get.updateLocale(Locale(lang));
    }
  }
}
