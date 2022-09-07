library fluent_window;


import 'package:flutter/rendering.dart';

class EdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height)
      ..arcToPoint(Offset(size.width, size.height / 2),
          radius: const Radius.circular(8))
    // ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - 8, 0)
      ..arcToPoint(Offset(0, size.height - 8),
          radius: const Radius.circular(12), clockwise: false)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
