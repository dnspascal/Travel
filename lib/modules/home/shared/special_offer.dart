import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpecialOffersWidget extends StatelessWidget {
  // Model for special offers
  final List<SpecialOffer> specialOffers;

  const SpecialOffersWidget({
    super.key,
    required this.specialOffers,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Special Offers',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(
                'assets/icons/svg/gift.svg', // Replace with your gift icon path
                color: Colors.blue[600],
                width: 24,
                height: 24,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Horizontal Scrollable Offers
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: specialOffers
                  .map((offer) => _SpecialOfferCard(offer: offer))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Separate widget for individual offer card for better performance
class _SpecialOfferCard extends StatelessWidget {
  final SpecialOffer offer;

  const _SpecialOfferCard({
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.yellow.shade400, Colors.orange.shade500],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            offer.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            offer.description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              offer.discount,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Model class for special offers
class SpecialOffer {
  final String id;
  final String title;
  final String description;
  final String discount;

  const SpecialOffer({
    required this.id,
    required this.title,
    required this.description,
    required this.discount,
  });
}

// Example usage
// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       body: SpecialOffersWidget(
//         specialOffers: [
//           SpecialOffer(
//             id: '1',
//             title: 'Summer Sale',
//             description: 'Get amazing discounts on all products',
//             discount: '50% OFF',
//           ),
//           // Add more offers...
//         ],
//       ),
//     ),
//   ));
// }
