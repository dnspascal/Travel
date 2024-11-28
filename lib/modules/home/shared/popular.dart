import 'package:flutter/material.dart';

Widget popularRoutes() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: (Column(
      children: [_header(), ],
    )),
  );
}

Widget _header() {
  return (Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        "Popular Routes",
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18.0),
      ),
      TextButton(
        onPressed: () => {},
        child: Text(
          'See All',
          style: TextStyle(color: Colors.blue.shade900),
        ),
      )
    ],
  ));
}

Widget _RouteCard() {
  return const Card(

  );
}
