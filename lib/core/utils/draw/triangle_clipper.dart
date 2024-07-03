import 'package:flutter/material.dart';

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 90);

    path.lineTo(size.width / 9 * 6, 40);
    path.quadraticBezierTo(size.width / 2, 10, (size.width / 9 * 3), 40);
    path.lineTo(0, 90);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}

class Triangle2Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 50);

    path.lineTo(size.width / 9 * 6, 70);
    path.quadraticBezierTo(size.width / 2, 80, (size.width / 9 * 3), 70);
    path.lineTo(0, 50);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}

class Triangle3Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 50);

    path.lineTo(size.width / 9 * 6, 20);
    path.quadraticBezierTo(size.width / 2, 0, (size.width / 9 * 3), 20);
    path.lineTo(0, 50);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
