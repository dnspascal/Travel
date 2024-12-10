import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Banner1 extends StatefulWidget {
  const Banner1({super.key});

  @override
  State<Banner1> createState() => _Banner1State();
}

class _Banner1State extends State<Banner1> {
  // void _toggleBanner() {
  //   setState(() {
  //     _showBanner = !_showBanner;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return
        // Obx(
        //   () => (
        Material(
          elevation: 2,
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'This is a custom banner',
                  style: TextStyle(color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => {},
                ),
              ],
            ),
          ),
        );
  }
}
