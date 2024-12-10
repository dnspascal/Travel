import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: LoaderPainter(_controller.value),
          child: const SizedBox(width: 76, height: 10),
        );
      },
    );
  }
}

class LoaderPainter extends CustomPainter {
  final double animationValue;

  LoaderPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Exact box-shadow recreation using circles
    final List<List<dynamic>> shadows = _getBoxShadows(animationValue);
    
    for (var shadow in shadows) {
      paint.color = Colors.black.withOpacity(shadow[2]);
      canvas.drawCircle(
        Offset(shadow[0], size.height / 2),
        4, // width/2
        paint,
      );
    }

    // Transform equivalent
    canvas.translate(-38, 0);
  }

  List<List<dynamic>> _getBoxShadows(double t) {
    if (t < 0.5) {
      return [
        [19.0, 0, 1.0], // x, y, opacity
        [38.0, 0, 0.5],
        [57.0, 0, 0.0]
      ];
    } else {
      return [
        [19.0, 0, 0.0],
        [38.0, 0, 1.0],
        [57.0, 0, 0.5]
      ];
    }
  }

  @override
  bool shouldRepaint(covariant LoaderPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}