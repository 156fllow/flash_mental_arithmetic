import 'dart:io';

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
  static bool TextEditing = true;

  static double showTime = 1.0;
  static int showCount = 4;
  static int digits = 3;

  static int input_answer_num = 0;

  static List<int> preDisplay = [];

  void initState() {
    super.initState();
    _textSection_controller = new TextEditingController(text: display);
  }

  @override
  Widget build(BuildContext context) {

    Future<void> Exam_Start(double showTime,int showCount,int digits) async {

      if(TextEditing == false){
        return;
      }

      TextEditing = false;
      input_answer_num = 0;

      preDisplay = [];
      int showTime_int = (showTime * 1000).toInt();
      var random = new math.Random();
      for(int i=0;i<showCount;i++){
        var num = random.nextInt(math.pow(10,digits) - math.pow(10,digits-1) + 1);
        num = num + math.pow(10,digits-1) - 1;
        // log(showTime_int.toString());
        preDisplay.add(num);
      }

      _textSection_controller.text = '';
      await Future.delayed(Duration(milliseconds: showTime_int));

      for(int i=0;i<showCount;i++){
        _textSection_controller.text = preDisplay[i].toString();
        await Future.delayed(Duration(milliseconds: showTime_int));
      }
      _textSection_controller.text = '';
      // log(preDisplay.toString());

      TextEditing = true;

    }

    Future<void> Exam_Retry(double showTime,int showCount,int digits) async {

      if(TextEditing == false){
        return;
      }

      TextEditing = false;
      input_answer_num = 0;

      int showTime_int = (showTime * 1000).toInt();

      _textSection_controller.text = '';
      await Future.delayed(Duration(milliseconds: showTime_int));

      for(int i=0;i<preDisplay.length;i++){
        _textSection_controller.text = preDisplay[i].toString();
        await Future.delayed(Duration(milliseconds: showTime_int));
      }
      _textSection_controller.text = '';
      // log(preDisplay.toString());

      TextEditing = true;

    }

    void input_answer(int input){

      if(TextEditing == false){
        return;
      }

      if(0 <= input && input <= 9){

        input_answer_num = input_answer_num * 10;
        input_answer_num = input_answer_num + input;
        _textSection_controller.text = input_answer_num.toString();
        // log(input_answer_num.toString());

      }else if(input == -1){

        input_answer_num = 0;
        _textSection_controller.text = '';

      }
    }

    bool correctness_decision(){
      int correct_num = preDisplay.reduce((a, b) => a + b);

      log('input=${correct_num.toString()},correct=${input_answer_num.toString()}');
      if(correct_num == input_answer_num){
        _textSection_controller.text = '〇';
        return true;
      }else{
        _textSection_controller.text = '×';
        return false;
      }
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
                  input_answer(7);
                },
                child: Text(
                  "7",
                ),
              ),
              FlatButton(
                onPressed: () {
                  input_answer(8);
                },
                child: Text(
                  "8",
                ),
              ),
              FlatButton(
                onPressed: () {
                  input_answer(9);
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
                  input_answer(4);
                },
                child: Text(
                  "4",
                ),
              ),
              FlatButton(
                onPressed: () {
                  input_answer(5);
                },
                child: Text(
                  "5",
                ),
              ),
              FlatButton(
                onPressed: () {
                  input_answer(6);
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
                  input_answer(1);
                },
                child: Text(
                  "1",
                ),
              ),
              FlatButton(
                onPressed: () {
                  input_answer(2);
                },
                child: Text(
                  "2",
                ),
              ),
              FlatButton(
                onPressed: () {
                  input_answer(3);
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
                  input_answer(0);
                },
                child: Text(
                  "0",
                ),
              ),
              FlatButton(
                onPressed: () {
                  input_answer(-1);
                },
                child: Text(
                  "AC",
                ),
              ),
              FlatButton(
                onPressed: () {
                  correctness_decision();
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
        ],

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

class SettingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("設定"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}




