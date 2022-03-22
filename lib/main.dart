import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'quizscreen.dart';
void main() {
  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizApp(),
    ),
  );
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Color(0xFF2D046E),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Center(
                child: Image(
                  image: AssetImage('assets/icon-circle.png'),
                  width: 300,
                  height: 300,
                ),
              ),
              Text(
                'Quiz',
                style: TextStyle(
                  color: Color(0xFFA20CBE),
                  fontSize: 90.0,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  onPressed: () {
                    Navigator.push(
                      context,
                    MaterialPageRoute(builder: (context)=>QuizScreen()));
                  },
                  color: Color(0xFFFFBA00),
                  textColor: Colors.white,
                  child: Text(
                    'PLAY',
                    style: TextStyle(fontSize: 32.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
