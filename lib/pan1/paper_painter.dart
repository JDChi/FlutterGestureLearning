import 'package:flutter/cupertino.dart';
import 'package:flutter_gesture_learning/pan/paint_model.dart';
import 'package:flutter_gesture_learning/pan1/paint_model.dart';

class PaperPainter1 extends CustomPainter {
  final PaintModel1 model;

  PaperPainter1({this.model}) : super(repaint: model);
  Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    final Matrix4 result = Matrix4.identity();
    result.translate(size.width / 2, size.height / 2);
    result.multiply(model.matrix);
    result.translate(-size.width / 2, -size.height / 2);
    canvas.transform(result.storage);

    model.lines.forEach(
        (element) => element.paint(canvas, _paint, size, model.matrix));
  }

  @override
  bool shouldRepaint(covariant PaperPainter1 oldDelegate) {
    return oldDelegate.model != model;
  }
}
