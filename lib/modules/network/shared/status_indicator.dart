// import 'package:flutter/material.dart';

// class StatusIndicator extends StatelessWidget {
//   final IconData icon;
//   final Color pulseColor;
//   final Color iconColor;

//   const StatusIndicator({
//     super.key,
//     required this.icon,
//     required this.pulseColor,
//     required this.iconColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         TweenAnimationBuilder<double>(
//           tween: Tween(begin: 0.0, end: 1.0),
//           duration: const Duration(seconds: 1),
//           builder: (context, value, child) {
//             return Transform.scale(
//               scale: 1.0 + (value * 0.3),
//               child: Opacity(
//                 opacity: 1 - value,
//                 child: Container(
//                   width: 24,
//                   height: 24,
//                   decoration: BoxDecoration(
//                     color: pulseColor,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             );
//           },
//           // repeat: true,
//         ),
//         Icon(icon, color: iconColor, size: 20),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';

class StatusIndicator extends StatefulWidget {
  final IconData icon;
  final Color pulseColor;
  final Color iconColor;

  const StatusIndicator({
    super.key,
    required this.icon,
    required this.pulseColor,
    required this.iconColor,
  });

  @override
  _StatusIndicatorState createState() => _StatusIndicatorState();
}

class _StatusIndicatorState extends State<StatusIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // Make the animation loop
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final scale = 1.0 + (_controller.value * 0.3);
            final opacity = 1.0 - _controller.value;

            return Transform.scale(
              scale: scale,
              child: Opacity(
                opacity: opacity,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: widget.pulseColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        ),
        Icon(widget.icon, color: widget.iconColor, size: 20),
      ],
    );
  }
}

