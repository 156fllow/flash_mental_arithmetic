import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:developer';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'フラッシュ暗算',
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
  _TopPage createState() => _TopPage();
}

class _TopPage extends State<MyHomePage>{
  void initState(){
    super.initState();
  }
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => SelectDiffMenu()));
          },
          child: const Text('Test Mode'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => FreeModePageState(title:widget.title)));
          },
          child: const Text('Free Mode'),
        )
      ]),
    );
  }
}

class SelectDiffMenu extends StatefulWidget{
  SelectDiffMenu({Key key}) : super(key: key);

  _SelectDiffMenu createState() => _SelectDiffMenu();
}

class _SelectDiffMenu extends State<SelectDiffMenu>{

  var TextObjdata = [

    Text("10級\t2桁\t2口\t4秒"),
    Text("9級\t2桁\t3口\t6秒"),
    Text("8級\t2桁\t4口\t7秒"),
    Text("7級\t2桁\t5口\t8秒"),
    Text("6級\t2桁\t6口\t9秒"),
    Text("5級\t2桁\t7口\t10秒"),
    Text("4級\t2桁\t8口\t11秒"),
    Text("3級\t2桁\t10口\t12秒"),
    Text("2級\t2桁\t12口\t12秒"),
    Text("1級\t2桁\t15口\t13秒"),
    Text("初段\t2桁\t15口\t10秒"),
    Text("二段\t3桁\t4口\t4秒"),
    Text("三段\t3桁\t6口\t5秒"),
    Text("四段\t3桁\t8口\t6秒"),
    Text("五段\t3桁\t10口\t7秒"),
    Text("六段\t3桁\t12口\t8秒"),
    Text("七段\t3桁\t15口\t8秒"),
    Text("八段\t3桁\t15口\t6秒"),
    Text("九段\t3桁\t15口\t4.5秒"),
    Text("十段\t3桁\t15口\t3秒"),
    Text("十一段\t3桁\t15口\t2.8秒"),
    Text("十二段\t3桁\t15口\t2.6秒"),
    Text("十三段\t3桁\t15口\t2.4秒"),
    Text("十四段\t3桁\t15口\t2.2秒"),
    Text("十五段\t3桁\t15口\t2.0秒"),
    Text("十六段\t3桁\t15口\t1.9秒"),
    Text("十七段\t3桁\t15口\t1.8秒"),
    Text("十八段\t3桁\t15口\t1.7秒"),
    Text("十九段\t3桁\t15口\t1.6秒"),
    Text("二十段\t3桁\t15口\t1.5秒"),
  ];

  var data = [
    [-10,2,2,4],
    [-9,2,3,6],
    [-8,2,4,7],
    [-7,2,5,8],
    [-6,2,6,9],
    [-5,2,7,10],
    [-4,2,8,11],
    [-3,2,10,12],
    [-2,2,12,12],
    [-1,2,15,13],
    [1,2,15,10],
    [2,3,4,4],
    [3,3,6,5],
    [4,3,8,6],
    [5,3,10,7],
    [6,3,12,8],
    [7,3,15,8],
    [8,3,15,6],
    [9,3,15,4.5],
    [10,3,15,3],
    [11,3,15,2.8],
    [12,3,15,2.6],
    [13,3,15,2.4],
    [14,3,15,2.2],
    [15,3,15,2.0],
    [16,3,15,1.9],
    [17,3,15,1.8],
    [18,3,15,1.7],
    [19,3,15,1.6],
    [20,3,15,1.5]
  ];


  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: const Text('選択メニュー'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,

        ),
        itemBuilder: (BuildContext context,int index) {
          return GestureDetector(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: new BorderRadius.all(const Radius.circular(10))
              ),
              child:TextObjdata[index]
            ),
            onTap: () {
              print(data[index]);
            },
          );
        },
        itemCount: data.length,
      ),
    );
  }
}

class FreeModePageState extends StatefulWidget{
  FreeModePageState({Key key,this.title}) : super(key: key);

  final String title;
  _FreeModePageState createState() => _FreeModePageState();

}

class _FreeModePageState extends State<FreeModePageState> {

  static String display = 'Press Start';

  static TextEditingController _textSection_controller;
  static bool TextEditing = true;

  static double showTime = 0.30;
  static int showCount = 5;
  static int digits = 2;

  static int input_answer_num = 0;

  static List<int> preDisplay = [];

  void initState() {
    super.initState();
    _textSection_controller = new TextEditingController(text: display);
  }

  @override
  Widget build(BuildContext context) {

    Future<void> Exam_Start(double showTime,int showCount,int digits) async {

      SharedPreferences prefs = await SharedPreferences.getInstance();

      double showTime;
      int showCount;
      int digits;
      if(prefs.containsKey('showTimeValue')){
        showTime = double.parse(prefs.getString('showTimeValue'));
      }else{
        showTime = 0.3;
      }
      if(prefs.containsKey('showCountValue')){
        showCount = int.parse(prefs.getString('showCountValue'));
      }else{
        showCount = 5;
      }
      if(prefs.containsKey('digitsValue')){
        digits = int.parse(prefs.getString('digitsValue'));
      }else{
        digits = 2;
      }

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
        _textSection_controller.text = correct_num.toString();
        return false;
      }
    }

    Widget textSection = Container(
        padding: const EdgeInsets.all(32),
        child: TextField(
          obscureText: false,
          controller: _textSection_controller,
          readOnly: true,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '',
          ),
          style: TextStyle(
            fontSize: 50
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

class SettingsPage extends StatefulWidget{
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage>{

  String digitsValue_String;
  String showTimeValue_String;
  String showCountValue_String;

  void initState(){
    super.initState();
  }

  Future<List<String>>settingsDataInitialize() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = ["2","0.30","5"];

    if(prefs.containsKey('digitsValue')){
      list[0] = prefs.getString('digitsValue');
    }

    if(prefs.containsKey('showTimeValue')){
      list[1] =  prefs.getString('showTimeValue');
    }

    if(prefs.containsKey('showCountValue')){
      list[2] = prefs.getString('showCountValue');
    }

    return list;

  }

  // store digits,time,count as String in SharedPreferences
  void saveSettingsData(String key,String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);

  }

  @override
  Widget build(BuildContext context){

    return new FutureBuilder(
      future: settingsDataInitialize(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot){
        print(snapshot);
        final hasData = snapshot.hasData;
        print("hasData:$hasData");
        if(hasData == false){
          return CircularProgressIndicator();
        }


        final isInitialized = snapshot.data;
        print("isInitialized:$isInitialized");
        digitsValue_String = isInitialized[0];
        showTimeValue_String = isInitialized[1];
        showCountValue_String = isInitialized[2];
        return Scaffold(
          appBar: AppBar(
            title: Text("設定"),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("桁数"),
              DropdownButton<String>(
                isExpanded: true,
                value: digitsValue_String,
                onChanged: (String newValue){
                  setState((){
                    digitsValue_String = newValue;
                    saveSettingsData('digitsValue', digitsValue_String);
                  });
                },
                items: <String>['1','2','3','4','5','6'].map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Text("速さ（秒/回）"),
              DropdownButton<String>(
                isExpanded: true,
                value: showTimeValue_String,
                onChanged: (String newValue){
                  setState((){
                    showTimeValue_String = newValue;
                    saveSettingsData('showTimeValue', showTimeValue_String);
                  });
                },
                items: <String>['0.10','0.15','0.20','0.25','0.30','0.35'].map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Text("回数"),
              DropdownButton<String>(
                isExpanded: true,
                value: showCountValue_String,
                onChanged: (String newValue){
                  setState((){
                    showCountValue_String = newValue;
                    saveSettingsData('showCountValue', showCountValue_String);
                  });
                },
                items: <String>['1','2','3','4','5'].map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }
    );
  }
}




