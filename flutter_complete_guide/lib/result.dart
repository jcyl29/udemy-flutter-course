import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultsScore;
  final Function resetHandler;

  Result(this.resultsScore, this.resetHandler);

  // getter method, does not take args
  // behaves like a property
  String get resultPhrase {
    print("resultsScore=" + resultsScore.toString());

    var resultText = 'You did it';
    if (resultsScore <= 8) {
      resultText = "You are awesome and innocent!";
    } else if (resultsScore <= 12) {
      resultText = 'Pretty likeable or something';
    } else if (resultsScore <= 16) {
      resultText = "You are ... strange";
    } else {
      resultText = "You're so bad!";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text('Restart Quiz!'),
            textColor: Colors.redAccent,
            onPressed: resetHandler,
          )
        ],
      ),
    );
  }
}
