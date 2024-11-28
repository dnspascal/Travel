import 'package:flutter/cupertino.dart';

class LoadingState extends StatelessWidget {
  final double radius;
  final Color? color;
  final bool animating;
  final double opacity;

  const LoadingState({
    super.key,
    this.radius = 15.0,
    this.color,
    this.animating = true,
    this.opacity = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: CupertinoActivityIndicator(
        radius: radius,
        color: color,
        animating: animating,
      ),
    );
  }
}
