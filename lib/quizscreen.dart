import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'QuizHelper.dart';
import 'package:http/http.dart' as http;
import 'ResultScreen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String apiURL =
      "https://opentdb.com/api.php?amount=10&category=18&type=multiple";
  QuizHelper? quizHelper;

  @override
  void initState() {
    // TODO: implement initState
    fetchAllQuiz();
    super.initState();
  }

  int currentQuestion = 0;
  int totalSecon = 30;
  int elapsedSeconds = 0;
  Timer? timer;
  int score = 0;

  fetchAllQuiz() async {
    var response = await http.get(apiURL);
    var body = response.body;
    var json = jsonDecode(body);

    setState(() {
      quizHelper = QuizHelper.fromJson(json);
      quizHelper!.results![currentQuestion].incorrectAnswers!
          .add(quizHelper!.results![currentQuestion].correctAnswer!);
      quizHelper!.results![currentQuestion].incorrectAnswers!.shuffle();
      initTimer();
    });
  }

  initTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == totalSecon) {
        print("Timer Completed");
        t.cancel();
        changeQuestion();
      } else {
        setState(() {
          elapsedSeconds = t.tick;
        });
      }
    });
  }

  changeQuestion() {
    timer!.cancel();
    if (currentQuestion == quizHelper!.results!.length - 1) {
      print('Quiz Completed');
      print('Score :$score');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ResultScree(
                    score: score,
                  )));
    } else {
      setState(() {
        currentQuestion += 1;
      });
      quizHelper!.results![currentQuestion].incorrectAnswers!
          .add(quizHelper!.results![currentQuestion].correctAnswer!);
      quizHelper!.results![currentQuestion].incorrectAnswers!.shuffle();
      initTimer();
    }
  }

  checkAnswer(answer) {
    String? correctAnswer = quizHelper!.results![currentQuestion].correctAnswer;
    if (correctAnswer == answer) {
      score += 1;
    } else {
      print('wrong');
    }
    changeQuestion();
  }

  @override
  Widget build(BuildContext context) {
    if (quizHelper != null) {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image(
                        image: AssetImage(
                          'assets/icon-circle.png',
                        ),
                        width: 70,
                        height: 70,
                      ),
                      Text(
                        '$elapsedSeconds S',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                //Question
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Q. ${quizHelper!.results![currentQuestion].question}',
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                //Options

                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Column(
                    children: quizHelper!
                        .results![currentQuestion].incorrectAnswers!
                        .map((option) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          color: Color(0xFF511AAB),
                          colorBrightness: Brightness.dark,
                          onPressed: () {
                            checkAnswer(option);
                          },
                          child: Text(
                            option,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
