import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gesture_learning/n_gesture_detector/n_tap_gesture_recognizer.dart';

class NGestureDetectorDemo extends StatefulWidget {
  const NGestureDetectorDemo({Key key}) : super(key: key);

  @override
  _NGestureDetectorDemoState createState() => _NGestureDetectorDemoState();
}

class _NGestureDetectorDemoState extends State<NGestureDetectorDemo> {
  String action = '';
  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("N Gesture Detector")),
      body: Center(
        child: RawGestureDetector(
          gestures: <Type, GestureRecognizerFactory>{
            NTapGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<NTapGestureRecognizer>(
                    () => NTapGestureRecognizer(maxN: 8),
                    (NTapGestureRecognizer instance) {
              instance
                ..onNTap = _nTap
                ..onNTapDown = _nTapDown
                ..onNTapCancel = _nTapCancel;
            }),
            TapGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(() {
              return TapGestureRecognizer();
            }, (TapGestureRecognizer instance) {
              instance
                ..onTapDown = _tapDown
                ..onTapCancel = _tapCancel
                ..onTapUp = _tapUp
                ..onTap = _tap;
            }),
          },
          child: Container(
            width: 100,
            height: 100,
            color: color,
            alignment: Alignment.center,
            child: Text(
              "action: $action",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void _nTapDown(TapDownDetails details, int count) {
    setState(() {
      action = 'down 第 $count 次';
      color = Colors.orange;
    });
  }

  void _nTap() {
    setState(() {
      action = '_on 8 Tap';
      color = Colors.green;
    });
  }

  void _nTapCancel(int count) {
    setState(() {
      action = '_onNTapCancel 第 $count 次';
      color = Colors.red;
    });
  }

  void _tapDown(TapDownDetails details) {
    print('_tapDown');
    setState(() {
      action = 'down';
      color = Colors.blue;
    });
  }

  void _tapUp(TapUpDetails details) {
    print('_tapUp');

    setState(() {
      action = 'up';
      color = Colors.blue;
    });
  }

  void _tap() {
    print('_tap');
    setState(() {
      action = 'tap';
      color = Colors.blue;
    });
  }

  void _tapCancel() {
    print('_tapCancel');
    setState(() {
      action = 'cancel';
      color = Colors.orange;
    });
  }
}
