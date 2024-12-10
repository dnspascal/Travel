import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel/domains/entities/profile.dart';

class ProfileController extends GetxController 
    with GetSingleTickerProviderStateMixin {
  final Rx<ProfileModel> _profile = ProfileModel(
    name: "Alex Thompson",
    email: "alex.thompson@travel.com",
    phone: "+1 (555) 123-4567",
    memberID: "BT-2024-5678",
    trips: 42,
    lastTrip: "New York to Boston",
    loyaltyPoints: 1250,
    upcomingTrips: [
      TripModel(
        id: 1, 
        from: "Boston", 
        to: "New York", 
        date: "2024-03-15", 
        time: "09:00 AM"
      ),
      TripModel(
        id: 2, 
        from: "New York", 
        to: "Philadelphia", 
        date: "2024-03-22", 
        time: "02:30 PM"
      ),
    ],
  ).obs;

  final RxBool isEditing = false.obs;
  final RxInt animatedTrips = 0.obs;
  final RxInt animatedPoints = 0.obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    startAnimations();
  }

  void startAnimations() {
    // Trips animation
    ever(
      animatedTrips, 
      (value) => value < _profile.value.trips 
        ? Future.delayed(
            const Duration(milliseconds: 10), 
            () => animatedTrips.value++
          ) 
        : null
    );

    // Points animation
    ever(
      animatedPoints, 
      (value) => value < _profile.value.loyaltyPoints 
        ? Future.delayed(
            const Duration(milliseconds: 20), 
            () => animatedPoints.value += 10
          ) 
        : null
    );

    animatedTrips.value = 0;
    animatedPoints.value = 0;
  }

  void toggleEditMode() {
    isEditing.toggle();
  }

  void updateProfile(ProfileModel newProfile) {
    _profile.value = newProfile;
    isEditing.value = false;
  }

  ProfileModel get profile => _profile.value;

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}