import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel/core/controllers/home_controller.dart';
import 'package:travel/modules/home/shared/popular.dart';
import 'package:travel/modules/home/shared/search.dart';

// ignore: must_be_immutable
class Home extends GetView<HomeController> {
  Home({super.key});

  bool expandedSearch = false;
  String? fromLocation;
  String? toLocation;

  final List<String> tanzanianCities = [
    'Dar es Salaam',
    'Dodoma',
    'Arusha',
    'Mwanza',
    'Zanzibar',
    'Moshi',
  ];

  final List<RouteModel> routes = [
    const RouteModel(
        id: '1',
        from: 'Dar es Salaam',
        to: 'Dodoma',
        company: 'DART Express',
        price: 25000,
        duration: '4hrs 30mins'),
    const RouteModel(
        id: '2',
        from: 'Arusha',
        to: 'Mwanza',
        company: 'Coastal Services',
        price: 35000,
        duration: '6hrs 15mins'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        const SearchSection(),
        const SizedBox(
          height: 16.0,
        ),
        PopularRoutesWidget(
          popularRoutes: routes,
        )
      ],
    ));
  }
}
