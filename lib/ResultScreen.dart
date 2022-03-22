import 'package:flutter/material.dart';
import 'quizscreen.dart';
class ResultScree extends StatelessWidget {
  final int? score;
  ResultScree({this.score});
  @override
  Widget build(BuildContext context) {
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
                'Result',
                style: TextStyle(
                  color: Color(0xFFA20CBE),
                  fontSize: 35.0,
                ),
              ),
              Text(
                '$score/10',
                style: TextStyle(
                  color: Color(0xFFFFBA00),
                  fontSize: 60.0,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QuizScreen()));
                  },
                  color: Color(0xFFFFBA00),
                  textColor: Colors.white,
                  child: Text(
                    'RESTART',
                    style: TextStyle(fontSize: 32.0),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  onPressed: () {
                    //Exit
                    Navigator.pop(context);
                  },
                  color: Color(0xFF511AB),
                  textColor: Colors.white,
                  child: Text(
                    'EXIT',
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
