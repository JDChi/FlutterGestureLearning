import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gesture_learning/stamp/background_painter.dart';
import 'package:flutter_gesture_learning/stamp/stamp.dart';
import 'package:flutter_gesture_learning/stamp/stamp_data.dart';
import 'package:flutter_gesture_learning/stamp/stamp_painter.dart';

class StampPaper extends StatefulWidget {
  const StampPaper({Key key}) : super(key: key);

  @override
  _StampPaperState createState() => _StampPaperState();
}

class _StampPaperState extends State<StampPaper> with TickerProviderStateMixin {
  final StampData stamps = StampData();
  int gridCount = 3;
  double radius = 0;
  double width = 0;
  int containsIndex = -1;
  GameState gameState = GameState.doing;

  bool get gameOver => gameState != GameState.doing;

  bool get contains => containsIndex != -1;

  int checkZone(Offset src) {
    for (int i = 0; i < stamps.stamps.length; i++) {
      Rect zone = Rect.fromCircle(
          center: stamps.stamps[i].center, radius: width / gridCount / 2);
      if (zone.contains(src)) {
        return i;
      }
    }
    return -1;
  }

  AnimationController _controller;
  final Duration animDuration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: animDuration)
      ..addListener(_listenAnim);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide * 0.8;
    return Scaffold(
      appBar: AppBar(title: Text("徽章")),
      body: Center(
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onDoubleTap: _onDoubleTap,
          onTapCancel: _onTapCancel,
          child: CustomPaint(
            foregroundPainter: StampPainter(stamps: stamps),
            painter: BackgroundPainter(count: gridCount),
            size: Size(width, width),
          ),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    if (gameOver) {
      return;
    }
    containsIndex = checkZone(details.localPosition);
    if (contains) {
      _controller.forward();
      return;
    }

    radius = width / 2 / gridCount * 0.618;
    stamps.push(Stamp(
        radius: radius, center: details.localPosition, color: Colors.grey));
  }

  void _onTapUp(TapUpDetails details) {
    if (contains || gameOver) {
      return;
    }
    stamps.activeLast(
        color: stamps.stamps.length % 2 == 0 ? Colors.red : Colors.blue);
    gameState = stamps.checkWin(width / gridCount);

    if (gameState == GameState.redWin) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Red Win!"), backgroundColor: Colors.red));
    } else if (gameState == GameState.blueWin) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Blue Win!"), backgroundColor: Colors.blue));
    }
  }

  void _onTapCancel() {
    if (contains || gameOver) return;
    stamps.removeLast();
  }

  void _onDoubleTap() {
    stamps.clear();
    gameState = GameState.doing;
  }

  @override
  void dispose() {
    stamps.dispose();
    super.dispose();
  }

  void _listenAnim() {
    if (_controller.value == 1.0) {
      _controller.reverse();
    }

    double rate = (0.9 - 1) * _controller.value + 1;
    stamps.animateAt(containsIndex, rate * radius);
  }
}
