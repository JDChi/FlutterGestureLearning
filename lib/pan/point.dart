import 'dart:math';

import 'package:flutter/cupertino.dart';

class Point {
  final double x;
  final double y;

  const Point({this.x, this.y});

  factory Point.fromOffset(Offset offset) {
    return Point(x: offset.dx, y: offset.dy);
  }

  double get distance => sqrt(x * x + y * y);

  Offset toOffset() => Offset(x, y);

  // 计算点与点之间的距离
  Point operator -(Point other) => Point(x: x - other.x, y: y - other.y);
}
