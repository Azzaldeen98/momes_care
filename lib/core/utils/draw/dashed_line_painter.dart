import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  DashedLinePainter(
      {this.color = Colors.grey,
      this.strokeWidth = 0.5,
      this.dashWidth = 4,
      this.dashSpace = 4});
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // const dashWidth = 5;
    // const dashSpace = 5;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );

      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(DashedLinePainter oldDelegate) => false;
}

class HorizontalDashedLinePainter extends CustomPainter {
  const HorizontalDashedLinePainter(
      {this.color = Colors.grey,
      this.strokeWidth = 0.5,
      this.dashWidth = 4,
      this.dashSpace = 4});
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );

      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(HorizontalDashedLinePainter oldDelegate) => false;
}
