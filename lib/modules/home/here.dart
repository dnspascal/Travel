// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// class LocationController extends GetxController {
//   // Nested location data structure
//   final locations = {
//     'Tanzania': {
//       'Dar es Salaam': ['City Center', 'Kariakoo', 'Msasani'],
//       'Dodoma': ['Capital City', 'Chamwino', 'Mpunguzi'],
//     },
//     'Kenya': {
//       'Nairobi': ['CBD', 'Westlands', 'Karen'],
//       'Mombasa': ['Old Town', 'Nyali', 'Bamburi'],
//     }
//   };

//   // Reactive variables for selected locations
//   final RxString selectedCountry = ''.obs;
//   final RxString selectedCity = ''.obs;
//   final RxString selectedSubLocation = ''.obs;

//   // Get available cities based on selected country
//   List<String> getAvailableCities() {
//     return selectedCountry.value.isNotEmpty
//       ? locations[selectedCountry.value]?.keys.toList() ?? []
//       : [];
//   }

//   // Get available sub-locations based on selected city
// List<String> getAvailableSubLocations() {
//   if (selectedCountry.value.isEmpty || selectedCity.value.isEmpty) {
//     return [];
//   }

//   return locations[selectedCountry.value]?[selectedCity.value] ?? [];
// }
//   // Reset selections
//   void resetSelections() {
//     selectedCountry.value = '';
//     selectedCity.value = '';
//     selectedSubLocation.value = '';
//   }

//   // Formatted location string
//   String get formattedLocation {
//     if (selectedSubLocation.value.isNotEmpty) {
//       return '$selectedCountry, $selectedCity, $selectedSubLocation';
//     } else if (selectedCity.value.isNotEmpty) {
//       return '$selectedCountry, $selectedCity';
//     } else if (selectedCountry.value.isNotEmpty) {
//       return selectedCountry.value;
//     }
//     return 'Select Location';
//   }
// }

// class CascaderLocationDropdown extends StatelessWidget {
//   final LocationController controller = Get.put(LocationController());
//   final bool isFrom;

//   CascaderLocationDropdown({Key? key, this.isFrom = true}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
//       height: 50.0,
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.location_on, color: Colors.white),
//           const SizedBox(width: 8),
//           Expanded(
//             child: GestureDetector(
//               onTap: () => _showCascaderDialog(context),
//               child: Obx(() => Text(
//                     controller.formattedLocation,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   )),
//             ),
//           ),
//           Icon(Icons.arrow_drop_down, color: Colors.white),
//         ],
//       ),
//     );
//   }

//   void _showCascaderDialog(BuildContext context) {
//     // Reset selections before opening dialog
//     controller.resetSelections();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Select ${isFrom ? 'Origin' : 'Destination'}'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Country Selection
//                 _buildCountrySelection(),

//                 // City Selection
//                 Obx(() => controller.selectedCountry.value.isNotEmpty
//                     ? _buildCitySelection()
//                     : SizedBox.shrink()),

//                 // Sub-Location Selection
//                 Obx(() => controller.selectedCity.value.isNotEmpty
//                     ? _buildSubLocationSelection()
//                     : SizedBox.shrink()),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildCountrySelection() {
//     return Column(
//       children: controller.locations.keys.map((country) {
//         return ListTile(
//           title: Text(country),
//           onTap: () {
//             controller.selectedCountry.value = country;
//             controller.selectedCity.value = '';
//             controller.selectedSubLocation.value = '';
//           },
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildCitySelection() {
//     return Column(
//       children: controller.getAvailableCities().map((city) {
//         return ListTile(
//           title: Text(city),
//           onTap: () {
//             controller.selectedCity.value = city;
//             controller.selectedSubLocation.value = '';
//           },
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildSubLocationSelection() {
//     return Column(
//       children: controller.getAvailableSubLocations().map((subLocation) {
//         return ListTile(
//           title: Text(subLocation),
//           onTap: () {
//             controller.selectedSubLocation.value = subLocation;
//             Navigator.of(Get.context!).pop();
//           },
//         );
//       }).toList(),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Here extends StatelessWidget {
  const Here({super.key});
  static const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
          body: DropdownButtonFormField(
        items: list
            .map((i) => DropdownMenuItem(
                  value: i,
                  child: Text(i),
                ))
            .toList(),
        onChanged: (value) {},
      ))),
    );
  }
}
