import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:developer';

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

  static TextEditingController _testwidget_controller;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          textSection,
          ratings,
          testwidget,
        ],
      ),
    );
  }

  Widget testwidget = Container(
    padding: const EdgeInsets.all(32),
    child: TextField(
      obscureText: true,
      controller: _testwidget_controller,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),

    )
  );

  void initState() {
    super.initState();
    _testwidget_controller = new TextEditingController(text:display);
  }

  Widget textSection = Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      '$display',
      softWrap: true,
    ),
  );


  final ratings = Container(
    padding: EdgeInsets.all(20),
    child: Row(
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
                "retry",
              ),
            ),
            FlatButton(
              onPressed: () {
                /*...*/
                var random = new math.Random();
                display = random.nextInt(10).toString();
                log(display);
              },
              child: Text(
                "start",
              ),
            ),
          ],
        )
      ],
    ),
  );
}
