import 'package:flutter/cupertino.dart';
import 'package:flutter_gesture_learning/pan/paint_model.dart';

class PaperPainter extends CustomPainter {
  final PaintModel model;

  PaperPainter({this.model}) : super(repaint: model);
  Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    model.lines.forEach((element) => element.paint(canvas, _paint));
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) {
    return oldDelegate.model != model;
  }
}
