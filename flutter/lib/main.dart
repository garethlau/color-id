import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colors',
      home: MyHomePage(title: 'Colors'),
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

  Random random = new Random();

  int r;
  int g;
  int b;

  Color questionColor = Color.fromRGBO(0, 0, 0, 1);

  void _selectColor(String colorName) {
    // save the rbg values and the color name before calling change question color
    print("RBG: " + r.toString() + g.toString() + b.toString() + "NAME: " + colorName);

    Firestore.instance.collection('colors').add({
      "red": r.toString(),
      "green": g.toString(),
      "blue": b.toString(),
      "label": colorName
    }).then((result) => {
      print("result is:" + result.toString())
    });

    _changeQuestionColor();

  } 

  void _changeQuestionColor() {
    setState(() {
      r = random.nextInt(256);
      g = random.nextInt(256);
      b = random.nextInt(256);
      questionColor = Color.fromRGBO(r, g, b, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    _changeQuestionColor();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0), 
              child: Container(
                color: questionColor,
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    _selectColor("RED");
                  },
                  child: Text(
                    "RED",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,  
                    )
                  ),
                  color: Colors.red,
                ),
                RaisedButton(
                  onPressed: () {
                    _selectColor("ORANGE");
                  },
                  child: Text(
                    "ORANGE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,  
                    )
                  ),
                  color: Colors.orange,
                ),
                RaisedButton(
                  onPressed: () {
                    _selectColor("YELLOW");
                  },
                  child: Text(
                    "Yellow",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,  
                    )
                  ),
                  color: Colors.yellow,
                ),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    _selectColor("GREEN");
                  },
                  child: Text(
                    "GREEN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,  
                    )
                  ),
                  color: Colors.green,
                ),
                RaisedButton(
                  onPressed: () {
                    _selectColor("BLUE");
                  },
                  child: Text(
                    "BLUE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,  
                    )
                  ),
                  color: Colors.blue,
                ),
                RaisedButton(
                  onPressed: () {
                    _selectColor("INDIGO");
                  },
                  child: Text(
                    "INDIGO",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,  
                    )
                  ),
                  color: Colors.indigo,
                ),  
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    _selectColor("VIOLET");
                  },
                  child: Text(
                    "VIOLET",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )
                  ),
                  color: Colors.purple,
                ),
                RaisedButton(
                  onPressed: () {
                    _selectColor("NONE");
                  },
                  child: Text(
                    "???",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.black,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LabelledColor {
  final int red;
  final int green;
  final int blue;
  final String label;
  LabelledColor({this.red, this.green, this.blue, this.label});
}