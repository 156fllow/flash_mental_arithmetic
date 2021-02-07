import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:developer';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'フラッシュ暗算'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static String display = 'Press Start';

  static TextEditingController _textSection_controller;

  static double showTime = 0.1;
  static int showCount = 10;
  static int digits = 3;

  static List<int> preDisplay = [];

  void initState() {
    super.initState();
    _textSection_controller = new TextEditingController(text: display);
  }

  @override
  Widget build(BuildContext context) {

    Future<void> Exam_Start(double showTime,int showCount,int digits) async {

      preDisplay = [];
      int showTime_int = (showTime * 1000).toInt();
      var random = new math.Random();
      for(int i=0;i<showCount;i++){
        var num = random.nextInt(math.pow(10,digits) - math.pow(10,digits-1) + 1);
        num = num + math.pow(10,digits-1) - 1;
        // log(showTime_int.toString());
        preDisplay.add(num);
      }

      for(int i=0;i<showCount;i++){
        _textSection_controller.text = preDisplay[i].toString();
        await Future.delayed(Duration(milliseconds: showTime_int));
      }
      _textSection_controller.text = '';
      log(preDisplay.toString());

    }

    Future<void> Exam_Retry(double showTime,int showCount,int digits) async {

      int showTime_int = (showTime * 1000).toInt();

      for(int i=0;i<preDisplay.length;i++){
        _textSection_controller.text = preDisplay[i].toString();
        await Future.delayed(Duration(milliseconds: showTime_int));
      }
      _textSection_controller.text = '';
      log(preDisplay.toString());

    }


    Widget textSection = Container(
        padding: const EdgeInsets.all(32),
        child: TextField(
          obscureText: false,
          controller: _textSection_controller,
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '',
          ),

        )
    );



    final controlSection = Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlatButton(
                onPressed: () {
                  Exam_Retry(showTime, showCount, digits);
                },
                child: Text(
                  "RETRY",
                ),
              ),
              FlatButton(
                onPressed: () {
                  Exam_Start(showTime, showCount, digits);
                },
                child: Text(
                  "START",
                ),
              ),
            ],
          )
        ],
      ),
    );

    final inputSection = Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlatButton(
                onPressed: () {
                  /*...*/
                },
                child: Text(
                  "7",
                ),
              ),
              FlatButton(
                onPressed: () {

                },
                child: Text(
                  "8",
                ),
              ),
              FlatButton(
                onPressed: () {

                },
                child: Text(
                  "9",
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlatButton(
                onPressed: () {
                  /*...*/
                },
                child: Text(
                  "4",
                ),
              ),
              FlatButton(
                onPressed: () {

                },
                child: Text(
                  "5",
                ),
              ),
              FlatButton(
                onPressed: () {

                },
                child: Text(
                  "6",
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlatButton(
                onPressed: () {
                  /*...*/
                },
                child: Text(
                  "1",
                ),
              ),
              FlatButton(
                onPressed: () {

                },
                child: Text(
                  "2",
                ),
              ),
              FlatButton(
                onPressed: () {

                },
                child: Text(
                  "3",
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlatButton(
                onPressed: () {
                  /*...*/
                },
                child: Text(
                  "0",
                ),
              ),
              FlatButton(
                onPressed: () {

                },
                child: Text(
                  "AC",
                ),
              ),
              FlatButton(
                onPressed: () {

                },
                child: Text(
                  "ANS",
                ),
              ),
            ],
          )

        ],
      ),
    );


    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          textSection,
          controlSection,
          inputSection,
        ],
      ),
    );
  }

}





