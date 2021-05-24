import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RawGestureDetectorDemo extends StatefulWidget {
  const RawGestureDetectorDemo({Key key}) : super(key: key);

  @override
  _RawGestureDetectorDemoState createState() => _RawGestureDetectorDemoState();
}

class _RawGestureDetectorDemoState extends State<RawGestureDetectorDemo> {
  String action = '';
  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Raw Gesture Detector")),
      body: Center(
        child: RawGestureDetector(
          gestures: <Type, GestureRecognizerFactory>{
            TapGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
                    () => TapGestureRecognizer(), (TapGestureRecognizer instance) {
              instance
                ..onTapDown = _tapDown
                ..onTapUp = _tapUp
                ..onTap = tap
                ..onTapCancel = _tapCancel;
            })
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

  void _tapDown(TapDownDetails details) {
    setState(() {
      action = 'down';
      color = Colors.blue;
    });
  }

  void _tapUp(TapUpDetails details) {
    setState(() {
      action = 'up';
      color = Colors.purple;
    });
  }

  void tap() {
    setState(() {
      action = 'tap';
    });
  }

  void _tapCancel() {
    setState(() {
      action = 'cancel';
      color = Colors.orange;
    });
  }
}
