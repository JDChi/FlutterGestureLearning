import 'package:flutter/material.dart';
import 'package:flutter_gesture_learning/spring/spring_widget.dart';
import 'package:flutter_gesture_learning/stamp/stamp_paper.dart';

const String springPage = "spring_page";
const String stampPaper = "stamp_paper";

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
        stampPaper: (context) => StampPaper()
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
                child: Text("徽章"))
          ],
        ),
      ),
    );
  }
}
