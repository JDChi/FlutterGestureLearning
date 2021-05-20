import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gesture_learning/scale/gesture_painter.dart';

class ScaleGestureDemo extends StatefulWidget {
  const ScaleGestureDemo({Key key}) : super(key: key);

  @override
  _ScaleGestureDemoState createState() => _ScaleGestureDemoState();
}

class _ScaleGestureDemoState extends State<ScaleGestureDemo> {
  final ValueNotifier<Matrix4> matrix =
      ValueNotifier<Matrix4>(Matrix4.identity());
  Matrix4 recodeMatrix = Matrix4.identity();

  /// 手指焦点位置
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("缩放")),
      body: Center(
        child: Container(
          height: 300 * 0.75,
          width: 300,
          color: Colors.cyanAccent.withOpacity(0.1),
          child: GestureDetector(
            onScaleStart: _onScaleStart,
            onScaleUpdate: _onScaleUpdate,
            onScaleEnd: _onScaleEnd,
            child: CustomPaint(
              painter: GesturePainter(matrix: matrix),
            ),
          ),
        ),
      ),
    );
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (details.pointerCount == 1) {
      matrix.value = Matrix4.translationValues(
              (details.focalPoint.dx - _offset.dx),
              (details.focalPoint.dy - _offset.dy),
              1)
          .multiplied(recodeMatrix);
    } else {
      if ((details.rotation * 180 / pi).abs() > 15) {
        matrix.value =
            recodeMatrix.multiplied(Matrix4.rotationZ(details.rotation));
      } else {
        if (details.scale == 1.0) return;
        matrix.value = recodeMatrix.multiplied(
            Matrix4.diagonal3Values(details.scale, details.scale, 1));
      }
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    recodeMatrix = matrix.value;
  }

  void _onScaleStart(ScaleStartDetails details) {
    if (details.pointerCount == 1) {
      _offset = details.focalPoint;
    }
  }
}
