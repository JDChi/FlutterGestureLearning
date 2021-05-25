import 'package:flutter/material.dart';
import 'package:flutter_gesture_learning/n_gesture_detector/n_gesture_detector_demo.dart';
import 'package:flutter_gesture_learning/pan/white_paper.dart';
import 'package:flutter_gesture_learning/pan1/white_paper1.dart';
import 'package:flutter_gesture_learning/raw_gesture_detector/raw_gesture_detector_demo.dart';
import 'package:flutter_gesture_learning/scale/scale_gesture_demo.dart';
import 'package:flutter_gesture_learning/spring/spring_widget.dart';
import 'package:flutter_gesture_learning/stamp/stamp_paper.dart';

const String springPage = "spring_page";
const String stampPaper = "stamp_paper";
const String whitePaper = "white_paper";
const String scaleGesture = "scale_gesture";
const String whitePaper1 = "white_paper1";
const String rawGestureDetectorDemo = "raw_gesture_detector_demo";
const String nGestureDetectorDemo = "n_gesture_detector_demo";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        springPage: (context) => SpringPage(),
        stampPaper: (context) => StampPaper(),
        whitePaper: (context) => WhitePaper(),
        scaleGesture: (context) => ScaleGestureDemo(),
        whitePaper1: (context) => WhitePaper1(),
        rawGestureDetectorDemo: (context) => RawGestureDetectorDemo(),
        nGestureDetectorDemo: (context) => NGestureDetectorDemo()
      },
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, springPage);
                },
                child: Text("弹簧手势练习")),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, stampPaper);
                },
                child: Text("徽章")),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, whitePaper);
                },
                child: Text("白板")),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, scaleGesture);
                },
                child: Text("缩放")),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, whitePaper1);
                },
                child: Text("白板1")),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, rawGestureDetectorDemo);
                },
                child: Text("raw gesture detector")),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, nGestureDetectorDemo);
                },
                child: Text("n gesture detector"))
          ],
        ),
      ),
    );
  }
}
