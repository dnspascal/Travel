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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [const SearchSection(), popularRoutes()],
    ));
  }
}
