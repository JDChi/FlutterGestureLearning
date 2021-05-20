import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gesture_learning/pan/paint_setting_dialog.dart';
import 'package:flutter_gesture_learning/pan/point.dart';
import 'package:flutter_gesture_learning/pan1/line1.dart';
import 'package:flutter_gesture_learning/pan1/paint_model.dart';
import 'package:flutter_gesture_learning/pan1/paper_painter.dart';

enum TransformType { none, translate, rotate, scale }

class WhitePaper1 extends StatefulWidget {
  const WhitePaper1({Key key}) : super(key: key);

  @override
  _WhitePaper1State createState() => _WhitePaper1State();
}

class _WhitePaper1State extends State<WhitePaper1> {
  final PaintModel1 paintModel = PaintModel1();
  Color lineColor = Colors.black;
  double strokeWidth = 1;

  ValueNotifier<TransformType> type =
      ValueNotifier<TransformType>(TransformType.none);
  Matrix4 recodeMatrix = Matrix4.identity();
  Offset _offset = Offset.zero;

  static const List<IconData> icons = [
    Icons.edit,
    Icons.api,
    Icons.rotate_90_degrees_ccw_sharp,
    Icons.expand,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("白板")),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _showSettingDialog,
            onScaleStart: _onScaleStart,
            onScaleUpdate: _onScaleUpdate,
            onScaleEnd: _onScaleEnd,
            onDoubleTap: _onDoubleTap,
            onLongPressStart: _onLongPressStart,
            onLongPressUp: _onLongPressUp,
            onLongPressMoveUpdate: _onLongPressMoveUpdate,
            child: CustomPaint(
              size: MediaQuery.of(context).size,
              painter: PaperPainter1(model: paintModel),
            ),
          ),
          Positioned(right: 20, top: 10, child: _buildTools())
        ],
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

  Widget _buildTools() {
    return ValueListenableBuilder(
      valueListenable: type,
      builder: (_, value, __) => Row(
        mainAxisSize: MainAxisSize.min,
        children: icons.asMap().keys.map((index) {
          bool active = value == TransformType.values[index];
          return IconButton(
              onPressed: () => type.value = TransformType.values[index],
              icon: Icon(
                icons[index],
                color: active ? Colors.blue : Colors.grey,
              ));
        }).toList(),
      ),
    );
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
    type.dispose();
    super.dispose();
  }

  void _onDoubleTap() {
    paintModel.clear();
  }

  void _onLongPressStart(LongPressStartDetails details) {
    paintModel.activeEditLine(Point.fromOffset(details.localPosition));
  }

  void _onLongPressUp() {
    paintModel.cancelEditLine();
  }

  void _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    paintModel.moveEditLine(details.offsetFromOrigin);
  }

  void _onScaleStart(ScaleStartDetails details) {
    switch (type.value) {
      case TransformType.none:
        Line line = Line(color: lineColor, strokeWidth: strokeWidth);
        paintModel.pushLine(line);
        break;
      case TransformType.translate:
        if (details.pointerCount == 1) {
          _offset = details.focalPoint;
        }
        break;
      case TransformType.rotate:
        break;
      case TransformType.scale:
        break;
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    switch (type.value) {
      case TransformType.none:
        paintModel.pushPoint(Point.fromOffset(details.localFocalPoint));
        break;
      case TransformType.translate:
        double dx = details.focalPoint.dx - _offset.dx;
        double dy = details.focalPoint.dy - _offset.dy;

        paintModel.matrix =
            Matrix4.translationValues(dx, dy, 1).multiplied(recodeMatrix);
        break;
      case TransformType.rotate:
        paintModel.matrix =
            recodeMatrix.multiplied(Matrix4.rotationZ(details.rotation));
        break;
      case TransformType.scale:
        if (details.scale == 1.0) return;
        paintModel.matrix = recodeMatrix.multiplied(
            Matrix4.diagonal3Values(details.scale, details.scale, 1));
        break;
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    switch (type.value) {
      case TransformType.none:
        paintModel.doneLine();
        paintModel.removeEmpty();
        break;
      case TransformType.translate:
      case TransformType.scale:
      case TransformType.rotate:
        recodeMatrix = paintModel.matrix;
        break;
    }
  }
}
