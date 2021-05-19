import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gesture_learning/pan/line.dart';
import 'package:flutter_gesture_learning/pan/paint_model.dart';
import 'package:flutter_gesture_learning/pan/paint_setting_dialog.dart';
import 'package:flutter_gesture_learning/pan/paper_painter.dart';
import 'package:flutter_gesture_learning/pan/point.dart';

class WhitePaper extends StatefulWidget {
  const WhitePaper({Key key}) : super(key: key);

  @override
  _WhitePaperState createState() => _WhitePaperState();
}

class _WhitePaperState extends State<WhitePaper> {
  final PaintModel paintModel = PaintModel();
  Color lineColor = Colors.black;
  double strokeWidth = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("白板")),
      body: GestureDetector(
        onTap: _showSettingDialog,
        onPanDown: _onPanDown,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        onPanCancel: _onPanCancel,
        onDoubleTap: _onDoubleTap,
        onLongPressStart: _onLongPressStart,
        onLongPressUp: _onLongPressUp,
        onLongPressMoveUpdate: _onLongPressMoveUpdate,
        child: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: PaperPainter(model: paintModel),
        ),
      ),
    );
  }

  void _showSettingDialog() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => PaintSettingDialog(
              initColor: lineColor,
              initWidth: strokeWidth,
              onLineWidthSelect: _selectWidth,
              onColorSelect: _selectColor,
            ));
  }

  void _selectWidth(double width) {
    strokeWidth = width;
  }

  void _selectColor(Color color) {
    lineColor = color;
  }

  @override
  void dispose() {
    paintModel.dispose();
    super.dispose();
  }

  void _onPanDown(DragDownDetails details) {
    Line line = Line(color: lineColor, strokeWidth: strokeWidth);
    paintModel.pushLine(line);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    paintModel.pushPoint(Point.fromOffset(details.localPosition));
  }

  void _onPanEnd(DragEndDetails details) {
    paintModel.doneLine();
  }

  void _onPanCancel() {
    paintModel.removeEmpty();
  }

  void _onDoubleTap() {}

  void _onLongPressStart(LongPressStartDetails details) {
    paintModel.activeEditLine(Point.fromOffset(details.localPosition));
  }

  void _onLongPressUp() {
    paintModel.cancelEditLine();
  }

  void _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    paintModel.moveEditLine(details.offsetFromOrigin);
  }
}
