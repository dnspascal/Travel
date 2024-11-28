import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:travel/core/controllers/home_controller.dart';

class SearchSection extends GetView<HomeController> {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.purple.shade600],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 16),
          _buildSearchForm(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLocationDropdown({
    required IconData icon,
    required String hint,
    required RxString value,
    required List<String> items,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: Obx(() => DropdownButton<String>(
                    value: value.value.isEmpty ? null : value.value,
                    hint: Text(hint,
                        style: const TextStyle(color: Colors.white70)),
                    items: items.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (newValue) => value.value = newValue ?? '',
                    dropdownColor: Colors.blue[600],
                    style: const TextStyle(color: Colors.white),
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.welcome,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Obx(() => TextButton(
              onPressed: controller.toggleExpandedSearch,
              style: TextButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                controller.isExpandedSearch.value ? 'Compact' : 'Expand',
                style: const TextStyle(color: Colors.white),
              ),
            )),
      ],
    );
  }

  Widget _buildSearchForm() {
    return Column(
      children: [
        _buildLocationDropdown(
          icon: Icons.location_on,
          hint: 'From',
          value: controller.fromLocation,
          items: controller.tanzanianCities,
        ),
        const SizedBox(height: 16),
        _buildLocationDropdown(
          icon: Icons.arrow_forward,
          hint: 'To',
          value: controller.toLocation,
          items: controller.getAvailableDestinations(),
        ),
        const SizedBox(height: 16),
        Obx(() {
          if (controller.isExpandedSearch.value) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildDatePicker()),
                    const SizedBox(width: 8),
                    Expanded(child: _buildPassengerSelector()),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue.shade800,
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Search Routes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDatePicker() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: TextButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  controller.selectedDate.value = picked;
                }
              },
              child: Obx(() => Text(
                    controller.selectedDate.value == null
                        ? 'Select Date'
                        : '${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}',
                    style: const TextStyle(color: Colors.white70),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassengerSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.people, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Obx(() => TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: controller.passengers.value.toString(),
                  onChanged: (value) {
                    int? passengers = int.tryParse(value);
                    if (passengers != null &&
                        passengers >= 1 &&
                        passengers <= 5) {
                      controller.passengers.value = passengers;
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Passengers',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
