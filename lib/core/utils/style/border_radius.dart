import 'package:flutter/material.dart';

abstract class BorderRadiusAttributes {
  static BorderRadius onlyTop(double radius) {
    return BorderRadius.only(
        topLeft: Radius.circular(radius), topRight: Radius.circular(radius));
  }

  static BorderRadius onlyBottom(double radius) {
    return BorderRadius.only(
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius));
  }

  static RoundedRectangleBorder onlyTopRounded(double radius) {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius)));
  }

  static RoundedRectangleBorder onlyBottomRounded(double radius) {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(radius),
            bottomRight: Radius.circular(radius)));
  }
}
