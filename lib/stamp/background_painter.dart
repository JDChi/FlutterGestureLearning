import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class BackgroundPainter extends CustomPainter {
  final int count;
  final Paint _pathPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  static const List<Color> colors = [
    Color(0xFFF60C0C),
    Color(0xFFF3B913),
    Color(0xFFE7F716),
    Color(0xFF3DF30B),
    Color(0xFF0DF6EF),
    Color(0xFF0829FB),
    Color(0xFFB709F4)
  ];

  static const List<double> pos = [
    1.0 / 7,
    2.0 / 7,
    3.0 / 7,
    4.0 / 7,
    5.0 / 7,
    6.0 / 7,
    1.0
  ];

  BackgroundPainter({this.count = 3});

  @override
  void paint(Canvas canvas, Size size) {
    Rect zone = Offset.zero & size;
    canvas.clipRect(zone);
    _pathPaint.shader = ui.Gradient.sweep(
        Offset(size.width / 2, size.height / 2),
        colors,
        pos,
        TileMode.mirror,
        pi / 2,
        pi);
    canvas.save();
    for (int i = 0; i < count - 1; i++) {
      canvas.translate(0, size.height / count);
      canvas.drawLine(Offset.zero, Offset(size.width, 0), _pathPaint);
    }
    canvas.restore();

    canvas.save();

    for (int i = 0; i < count - 1; i++) {
      canvas.translate(size.width / count, 0);
      canvas.drawLine(Offset.zero, Offset(0, size.height), _pathPaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant BackgroundPainter oldDelegate) {
    return count != oldDelegate.count;
  }
}
