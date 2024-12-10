import 'package:flutter/material.dart';

extension WidgetModifiers on Widget {
  Widget padding({EdgeInsets? insets}) {
    return Padding(
      padding: insets ?? const EdgeInsets.all(8.0),
      child: this,
    );
  }

  Widget margin({EdgeInsets? insets}) {
    return Container(
      margin: insets ?? const EdgeInsets.all(8.0),
      child: this,
    );
  }

  Widget backgroundColor(Color color) {
    return Container(
      color: color,
      child: this,
    );
  }

  Widget center() {
    return Center(child: this);
  }
}
