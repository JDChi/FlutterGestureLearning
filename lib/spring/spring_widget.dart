import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gesture_learning/spring/spring_paint.dart';

const double _kDefaultSpringHeight = 100;
const double _kRateOfMove = 1.5;

class SpringPage extends StatefulWidget {
  @override
  _SpringPageState createState() => _SpringPageState();
}

class _SpringPageState extends State<SpringPage> with TickerProviderStateMixin {
  ValueNotifier<double> height = ValueNotifier(_kDefaultSpringHeight);
  double s = 0;
  AnimationController animationController;
  Animation<double> animation;
  final Duration animDuration = const Duration(milliseconds: 400);
  double lastMoveLen = 0;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: animDuration)
          ..addListener(updateHeightByAnim);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("弹簧手势")),
      body: Center(
        child: GestureDetector(
          onVerticalDragUpdate: _updateWidget,
          onVerticalDragEnd: _animateToDefault,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.grey.withAlpha(11),
            child: CustomPaint(painter: SpringPainter(height: height)),
          ),
        ),
      ),
    );
  }

  double get dx => -s / _kRateOfMove;

  void _updateWidget(DragUpdateDetails details) {
    s += details.delta.dy;
    height.value = _kDefaultSpringHeight + dx;
  }

  void updateHeightByAnim() {
    debugPrint("lastMoveLen = $lastMoveLen");
    debugPrint("controller.value = ${animationController.value}");
    s = lastMoveLen * (1 - animationController.value);
    height.value = _kDefaultSpringHeight + (-s / _kRateOfMove);
  }

  void _animateToDefault(DragEndDetails details) {
    lastMoveLen = s;
    animationController.forward(from: 0);
  }

  @override
  void dispose() {
    animationController.dispose();
    height.dispose();
    super.dispose();
  }
}

class Interpolator extends Curve {
  const Interpolator();

  @override
  double transformInternal(double t) {
    t -= 1.0;
    return t * t * t * t * t + 1.0;
  }
}
