import 'package:flutter/material.dart';

class StatusConfig {
  final IconData icon;
  final LinearGradient gradient;
  final Color textColor;
  final Color pulseColor;
  final String message;
  final String description;

  StatusConfig({
    required this.icon,
    required this.gradient,
    required this.textColor,
    required this.pulseColor,
    required this.message,
    required this.description,
  });
}
