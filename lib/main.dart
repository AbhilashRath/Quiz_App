import 'package:flutter/material.dart';
import 'package:quizzler/question.dart';
import 'package:quizzler/quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain  = new QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [];
  int score = 0;
  void checkAnswer(bool userAnswer){
    bool correctAnswer = quizBrain.getAnswerText();
    setState(() {
      if (!quizBrain.isFinished()) {
        if(userAnswer==correctAnswer){
                scorekeeper.add(
                    Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 20,
                    )
                );
                score++;
              }else{
                scorekeeper.add(
                    Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 20,
                    )
                );
              }
        quizBrain.nextQuestion();
      } else {
        Alert(
          context: context,
          title: 'Congrats!',
          desc: 'You\'ve scored ${score}/${quizBrain.getNumOfQuestions()} in this quiz.',
        ).show();
        quizBrain.reset();
        scorekeeper=[];
        score = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SafeArea(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 16,bottom: 10),
                child: Text(
                  "Question ${quizBrain.getQuestionNumber() + 1}/${quizBrain
                      .getNumOfQuestions()}", style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold),)
            ),
          ) ,
        ),
        SizedBox(
          child: Divider(
            thickness: 1,
            color: Colors.white,
          ),
        ),
        Expanded(
          flex: 4,
          child: Center(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Text(quizBrain.getQuestionText(),
                style: TextStyle(
                    fontFamily: "Comfortaa", fontSize: 24, color: Colors.white),
                textAlign: TextAlign.center,),
            ),
          ),
        ),
        Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 10),
              child: OutlineButton(
                  child: Text("True",
                    style: TextStyle(
                        fontFamily: "Comfortaa",
                        fontSize: 24,
                        color: Colors.white),
                    textAlign: TextAlign.center,),
                  disabledBorderColor: Colors.white,
                  highlightColor: Colors.teal,
                  highlightedBorderColor: Colors.green,
                  borderSide: BorderSide(
                    color: Colors.green[600],
                  ),
                  onPressed: (){
                    checkAnswer(true);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )
              ),
            )
        ),
        Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 10),
              child: OutlineButton(
                  child: Text("False",
                    style: TextStyle(
                        fontFamily: "Comfortaa",
                        fontSize: 24,
                        color: Colors.white),
                    textAlign: TextAlign.center,),
                  disabledBorderColor: Colors.white,
                  highlightedBorderColor: Colors.red,
                  highlightColor: Colors.red[400],
                  onPressed: (){
                    checkAnswer(false);
                  },
                  borderSide: BorderSide(
                    color: Colors.red
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )
              ),
            )
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
          child: Row(
            children: scorekeeper
          ),
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
