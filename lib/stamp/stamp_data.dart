import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gesture_learning/stamp/stamp.dart';

enum GameState { doing, redWin, blueWin }

enum CheckModel { horizontal, vertical, leftDiagonal, rightDiagonal }

class StampData extends ChangeNotifier {
  final List<Stamp> stamps = [];
  final Paint _paint = Paint();

  void push(Stamp stamp) {
    stamps.add(stamp);
    notifyListeners();
  }

  void removeLast() {
    stamps.removeLast();
    notifyListeners();
  }

  void activeLast({Color color = Colors.blue}) {
    stamps.last.color = color;
    notifyListeners();
  }

  void clear() {
    stamps.clear();
    notifyListeners();
  }

  void animateAt(int index, double radius) {
    stamps[index].radius = radius;
    stamps[index].rePath();
    notifyListeners();
  }

  GameState checkWin(double length) {
    bool redWin = _checkWinByColor(length, Colors.red);
    if (redWin) return GameState.redWin;

    bool blueWin = _checkWinByColor(length, Colors.blue);
    if (blueWin) return GameState.blueWin;
    return GameState.doing;
  }

  bool _checkWinByColor(double length, Color color) {
    // 获取目标颜色的中心点组成的列表
    List<Offset> targetColors = stamps
        .where((element) => element.color == color)
        .map((e) => e.center)
        .toList();

    List<Point<int>> targetColorPoints = targetColors
        .map((e) => Point<int>(e.dx ~/ length, e.dy ~/ length))
        .toList();
    return _checkWinInline(targetColorPoints, 3);
  }

  bool _checkWinInline(List<Point<int>> points, int max) {
    if (points.length < max) return false;
    for (int i = 0; i < points.length; i++) {
      int x = points[i].x;
      int y = points[i].y;

      if (_check(x, y, points, CheckModel.horizontal, max)) {
        return true;
      } else if (_check(x, y, points, CheckModel.vertical, max)) {
        return true;
      } else if (_check(x, y, points, CheckModel.leftDiagonal, max)) {
        return true;
      } else if (_check(x, y, points, CheckModel.rightDiagonal, max)) {
        return true;
      }
    }
    return false;
  }

  bool _check(
      int x, int y, List<Point<int>> points, CheckModel checkModel, int max) {
    int count = 1;
    Point checkPoint;
    // 检查每个点落的区域是否连成满足的一线
    for (int i = 1; i < max; i++) {
      switch (checkModel) {
        case CheckModel.horizontal:
          checkPoint = Point(x - i, y);
          break;
        case CheckModel.vertical:
          checkPoint = Point(x, y - i);
          break;
        case CheckModel.leftDiagonal:
          checkPoint = Point(x - i, y + i);
          break;
        case CheckModel.rightDiagonal:
          checkPoint = Point(x + i, y + i);
          break;
      }
      if (points.contains(checkPoint)) {
        count++;
      } else {
        break;
      }
    }
    if (count == max) {
      return true;
    }
    return false;
  }
}
