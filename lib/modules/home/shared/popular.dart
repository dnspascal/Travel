// import 'package:flutter/material.dart';

// Widget popularRoutes() {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: (Column(
//       children: [_header(), ],
//     )),
//   );
// }

// Widget _header() {
//   return (Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       const Text(
//         "Popular Routes",
//         style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18.0),
//       ),
//       TextButton(
//         onPressed: () => {},
//         child: Text(
//           'See All',
//           style: TextStyle(color: Colors.blue.shade900),
//         ),
//       )
//     ],
//   ));
// }

// Widget _RouteCard() {
//   return const Card(

//   );
// }

import 'package:flutter/material.dart';

// Immutable data class for route information
@immutable
class RouteModel {
  final String id;
  final String from;
  final String to;
  final String company;
  final double price;
  final String duration;

  const RouteModel({
    required this.id,
    required this.from,
    required this.to,
    required this.company,
    required this.price,
    required this.duration,
  });
}

class PopularRoutesWidget extends StatelessWidget {
  final List<RouteModel> popularRoutes;

  const PopularRoutesWidget({
    super.key,
    required this.popularRoutes,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 8.0),
            _buildRoutesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Popular Routes',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        GestureDetector(
          onTap: () {
            // Add navigation logic here
          },
          child: Text(
            'See All',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoutesList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: popularRoutes.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10.0),
      itemBuilder: (context, index) {
        return _RouteCard(route: popularRoutes[index]);
      },
    );
  }
}

class _RouteCard extends StatelessWidget {
  final RouteModel route;

  const _RouteCard({required this.route});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(0, -1),
            blurRadius: 4,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            _buildRouteDetails(context),
            const SizedBox(width: 16),
            _buildPriceDetails(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteDetails(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_pin,
                color: Colors.blue.shade800,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${route.from} → ${route.to}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            route.company,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'TSh ${route.price.toStringAsFixed(0)}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          route.duration,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }
}
