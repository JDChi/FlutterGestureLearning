import 'package:flutter/cupertino.dart';
import 'package:flutter_gesture_learning/pan/line.dart';
import 'package:flutter_gesture_learning/pan/point.dart';

class PaintModel extends ChangeNotifier {
  List<Line> _lines = [];
  final double tolerance = 18.0;

  List<Line> get lines => _lines;

  Line get activeLine =>
      _lines.singleWhere((element) => element.state == PaintState.doing,
          orElse: () => null);

  Line get editLine =>
      _lines.singleWhere((element) => element.state == PaintState.edit,
          orElse: () => null);

  void activeEditLine(Point point) {
    List<Line> lines = _lines
        .where((element) => element.path.getBounds().contains(point.toOffset()))
        .toList();
    if (lines.isNotEmpty) {
      lines[0].state = PaintState.edit;
      lines[0].recode();
      notifyListeners();
    }
  }

  void cancelEditLine() {
    _lines.forEach((element) => element.state = PaintState.done);
    notifyListeners();
  }

  void moveEditLine(Offset offset) {
    if (editLine == null) return;
    editLine.translate(offset);
    notifyListeners();
  }

  void pushLine(Line line) {
    _lines.add(line);
  }

  /// [force] 是否强制进行距离校验
  void pushPoint(Point point, {bool force = false}) {
    if (activeLine == null) return;

    if (activeLine.points.isNotEmpty && !force) {
      if ((point - activeLine.points.last).distance < tolerance) return;
    }
    activeLine.points.add(point);
    notifyListeners();
  }

  void doneLine() {
    if (activeLine == null) return;
    activeLine.state = PaintState.done;
    notifyListeners();
  }

  void clear() {
    _lines.forEach((element) => element.points.clear());
    _lines.clear();
    notifyListeners();
  }

  void removeEmpty() {
    _lines.removeWhere((element) => element.points.length == 0);
  }
}
