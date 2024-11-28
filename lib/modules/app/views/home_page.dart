// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:travel/features/app/controller/search_controller.dart';

// class SearchSection extends StatelessWidget {
//   final SearchController1 controller = Get.put(SearchController1());

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.blue[600]!, Colors.purple[600]!],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       padding: EdgeInsets.all(16),
//       child: Column(
//         children: [
//           _buildHeader(),
//           SizedBox(height: 16),
//           _buildSearchForm(),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           'Find Your Journey',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         Obx(() => TextButton(
//               onPressed: controller.toggleExpandedSearch,
//               child: Text(
//                 controller.isExpandedSearch.value ? 'Compact' : 'Expand',
//                 style: TextStyle(color: Colors.white),
//               ),
//               style: TextButton.styleFrom(
//                 backgroundColor: Colors.white.withOpacity(0.2),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             )),
//       ],
//     );
//   }

//   Widget _buildSearchForm() {
//     return Column(
//       children: [
//         _buildLocationDropdown(
//           icon: Icons.location_on,
//           hint: 'From',
//           value: controller.fromLocation,
//           items: controller.tanzanianCities,
//         ),
//         SizedBox(height: 16),
//         _buildLocationDropdown(
//           icon: Icons.arrow_forward,
//           hint: 'To',
//           value: controller.toLocation,
//           items: controller.getAvailableDestinations(),
//         ),
//         SizedBox(height: 16),
//         Obx(() {
//           if (true) {
//             return Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(child: _buildDatePicker()),
//                     SizedBox(width: 8),
//                     Expanded(child: _buildPassengerSelector()),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//               ],
//             );
//           }
//           return SizedBox.shrink();
//         }),
//         _buildSearchButton(),
//       ],
//     );
//   }

//   Widget _buildLocationDropdown({
//     required IconData icon,
//     required String hint,
//     required RxString value,
//     required List<String> items,
//   }) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.white),
//           SizedBox(width: 8),
//           Expanded(
//             child: DropdownButtonHideUnderline(
//               child: Obx(() => DropdownButton<String>(
//                     value: value.value.isEmpty ? null : value.value,
//                     hint: Text(hint, style: TextStyle(color: Colors.white70)),
//                     items: items.map((String city) {
//                       return DropdownMenuItem<String>(
//                         value: city,
//                         child: Text(city),
//                       );
//                     }).toList(),
//                     onChanged: (newValue) => value.value = newValue ?? '',
//                     dropdownColor: Colors.blue[600],
//                     style: TextStyle(color: Colors.white),
//                     icon: Icon(Icons.arrow_drop_down, color: Colors.white),
//                   )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDatePicker() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.calendar_today, color: Colors.white),
//           SizedBox(width: 8),
//           Expanded(
//             child: TextButton(
//               onPressed: () async {
//                 final DateTime? picked = await showDatePicker(
//                   context: Get.context!,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime.now().add(Duration(days: 365)),
//                 );
//                 if (picked != null) {
//                   // controller.selectedDate.value = picked;
//                 }
//               },
//               child: Obx(() => Text(
//                   controller.selectedDate.value == null
//                   ? 'Select Date'
//                   : '${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}',
//                   style: TextStyle(color: Colors.white70),
//                   )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPassengerSelector() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.people, color: Colors.white),
//           SizedBox(width: 8),
//           Expanded(
//             child: Obx(() => TextFormField(
//                   keyboardType: TextInputType.number,
//                   initialValue: controller.passengers.value.toString(),
//                   onChanged: (value) {
//                     int? passengers = int.tryParse(value);
//                     if (passengers != null &&
//                         passengers >= 1 &&
//                         passengers <= 5) {
//                       controller.passengers.value = passengers;
//                     }
//                   },
//                   style: TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: 'Passengers',
//                     hintStyle: TextStyle(color: Colors.white70),
//                     border: InputBorder.none,
//                   ),
//                 )),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchButton() {
//     return ElevatedButton(
//       onPressed: () {
//         // Implement search functionality
//       },
//       child: Text(
//         'Search Routes',
//         style: TextStyle(
//           color: Colors.blue[600],
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.white,
//         padding: EdgeInsets.symmetric(vertical: 16),
//         minimumSize: Size(double.infinity, 50),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     );
//   }
// }
