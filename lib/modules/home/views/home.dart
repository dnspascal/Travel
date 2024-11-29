import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel/core/controllers/home_controller.dart';
import 'package:travel/modules/home/shared/popular.dart';
import 'package:travel/modules/home/shared/search.dart';
import 'package:travel/modules/home/shared/special_offer.dart';

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
    // const RouteModel(
    //     id: '3',
    //     from: 'Mbeya',
    //     to: 'Mwanza',
    //     company: 'Coastal Services',
    //     price: 95000,
    //     duration: '16hrs 15mins'),
  ];

  @override
  Widget build(BuildContext context) {
    final popular = PopularRoutesWidget(popularRoutes: routes);
    return SingleChildScrollView(
        child: Column(
      children: [
        const SearchSection(),
        const SizedBox(
          height: 16.0,
        ),
        popular.buildHeader(context),
        const SizedBox(
          height: 16.0,
        ),
        PopularRoutesWidget(
          popularRoutes: routes,
        ),
        const SizedBox(
          height: 16.0,
        ),
        const SpecialOffersWidget(
          specialOffers: [
            SpecialOffer(
              id: '1',
              title: 'Summer Sale',
              description: 'Get amazing discounts on all products',
              discount: '50% OFF',
            ),
            SpecialOffer(
              id: '1',
              title: 'Summer Sale',
              description: 'Get amazing discounts on all products',
              discount: '50% OFF',
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        PopularRoutesWidget(
          popularRoutes: routes,
        ),
        const SizedBox(height: 16.0),
      ],
    ));
  }
}
