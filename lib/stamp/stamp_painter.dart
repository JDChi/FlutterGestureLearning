import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gesture_learning/stamp/stamp_data.dart';

class StampPainter extends CustomPainter {
  final StampData stamps;
  final int count;
  final Paint _paint = Paint();
  final Paint _pathPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke;

  StampPainter({this.stamps, this.count = 3}) : super(repaint: stamps);

  @override
  void paint(Canvas canvas, Size size) {
    Rect zone = Offset.zero & size;
    canvas.clipRect(zone);

    stamps.stamps.forEach((element) {
      double length = size.width / count;
      int x = element.center.dx ~/ (size.width / count);
      int y = element.center.dy ~/ (size.width / count);
      double strokeWidth = element.radius * 0.07;

      Offset center = Offset(length * x + length / 2, length * y + length / 2);
      element.center = center;

      canvas.drawCircle(
          element.center, element.radius, _paint..color = element.color);
      canvas.drawPath(
          element.path,
          _pathPaint
            ..color = Colors.white
            ..strokeWidth = strokeWidth);
      canvas.drawCircle(element.center, element.radius + strokeWidth * 1.5,
          _pathPaint..color = element.color);
    });
  }

  @override
  bool shouldRepaint(covariant StampPainter oldDelegate) {
    return this.stamps != oldDelegate.stamps || this.count != oldDelegate.count;
  }
}
