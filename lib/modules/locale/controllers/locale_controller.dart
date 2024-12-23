import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleController extends GetxController {
  final GetStorage _storage = GetStorage();
  final _key = 'selected_lang';
  final isFirstLaunch = true.obs;

  var languageCode = 'sw'.obs;

  get selectedLanguage => null;

  @override
  void onInit() {
    super.onInit();
    _loadInitialSettings();
  }

  Future<void> _loadInitialSettings() async {
    isFirstLaunch.value = _storage.read('is_first_launch')
        ? _storage.read('is_first_launch')
        : true;
    if (isFirstLaunch.value) {
      _storage.write('is_first_launch', false);
    }

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

  Future<void> setLanguage(String langCode) async {
    languageCode.value = langCode;
    await _storage.write('language_code', langCode);
    await _storage.write('is_first_launch', false);
    await updateLocale(langCode);
  }

  Future<void> updateLocale(String langCode) async {
    final locale = Locale(langCode);
    await Get.updateLocale(locale);
  }

  bool shouldShowLanguageSelection() => isFirstLaunch.value;
}
