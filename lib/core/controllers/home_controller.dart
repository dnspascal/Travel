import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxString fromLocation = ''.obs;
  final RxString toLocation = ''.obs;
  final RxBool isExpandedSearch = false.obs;
  final RxInt passengers = 1.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  final List<String> tanzanianCities = [
    'Dar es Salaam',
    'Dodoma',
    'Arusha',
    'Mwanza',
    'Mbeya',
    'Makambako',
    'Tanga',
    'Morogoro'
  ];

  List<String> getAvailableDestinations() {
    return tanzanianCities.where((city) => city != fromLocation.value).toList();
  }

  void toggleExpandedSearch() {
    isExpandedSearch.value = !isExpandedSearch.value;
  }
}
