import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleController extends GetxController {
  final GetStorage _storage = GetStorage();
  final _key = 'selected_lang';

  String _languageCode = 'en';

  String get languageCode => _languageCode;

  @override
  void onInit() {
    super.onInit();
    final storedLang = _storage.read(_key);
    if (storedLang != null) {
      _languageCode = storedLang;
    }
    update();
  }

  void changeLanguage(String languageCode) {
    _languageCode = languageCode;
    _storage.write(_key, _languageCode);
    update();
  }
}
