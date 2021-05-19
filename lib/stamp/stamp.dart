import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Stamp {
  Color color;
  Offset center;
  double radius;

  Stamp({this.color = Colors.blue, this.center, this.radius = 20});

  Path _path;

  Path get path {
    if (_path == null) {
      _path = Path();
      double r = radius;
      double rad = 30 / 180 * pi;

      _path
        ..moveTo(center.dx, center.dy)
        ..relativeMoveTo(r * cos(rad), -r * sin(rad))
        ..relativeLineTo(-2 * r * cos(rad), 0)
        ..relativeLineTo(r * cos(rad), r + r * sin(rad))
        ..relativeLineTo(r * cos(rad), -(r + r * sin(rad)));

      _path
        ..moveTo(center.dx, center.dy)
        ..relativeMoveTo(0, -r)
        ..relativeLineTo(-r * cos(rad), r + r * sin(rad))
        ..relativeLineTo(2 * r * cos(rad), 0)
        ..relativeLineTo(-r * cos(rad), -(r + r * sin(rad)));
    }
    return _path;
  }

  void rePath() {
    _path = null;
    _path = path;
  }
}
