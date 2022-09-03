import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result = "0";
  String expression = "";
  buttonPressed(String value) {
    print(value);

    setState(() {
      if (value == "CLEAR") {
        result = "0";
      } else if (value == ".") {
        if (result.contains(".")) {
          return;
        } else {
          result = result + value;
        }
      } else if (value == "=") {
        expression = result.replaceAll("x", "*");

        Parser p = Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        dynamic calculate = exp.evaluate(EvaluationType.REAL, cm);

        result = "$calculate";
      } else {
        if (result == "0") {
          result = value;
        } else {
          result = result + value;
        }
      }
    });
  }

  Widget myButton(String buttonLabel) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonLabel),
        child: Text(buttonLabel,
            style: TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 153, 14, 171))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(222, 188, 158, 181),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(222, 10, 10, 20),
          title: Text(
            "papraewa",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              //alignment: Alignment.center,
              child: Text(
                result,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 2, 56, 249),
                ),
              ),
            ),
            Expanded(
                child: Image(
                    image: NetworkImage(
                        'https://t1.blockdit.com/photos/2019/11/5dc193c46d30ca144f79b9b5_800x0xcover_0vx8N0Nu.jpg'))),
            Column(
              children: [
                Row(
                  children: [
                    myButton("7"),
                    myButton("8"),
                    myButton("9"),
                    myButton("/"),
                  ],
                ),
                Row(
                  children: [
                    myButton("4"),
                    myButton("5"),
                    myButton("6"),
                    myButton("x"),
                  ],
                ),
                Row(
                  children: [
                    myButton("1"),
                    myButton("2"),
                    myButton("3"),
                    myButton("-"),
                  ],
                ),
                Row(
                  children: [
                    myButton("."),
                    myButton("0"),
                    myButton("00"),
                    myButton("+"),
                  ],
                ),
                Row(
                  children: [
                    myButton("CLEAR"),
                    myButton("="),
                  ],
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
