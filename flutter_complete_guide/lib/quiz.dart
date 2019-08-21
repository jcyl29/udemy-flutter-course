import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz(
      {@required this.questions,
      @required this.answerQuestion,
      @required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Question(questions[questionIndex]['questionText']),
        ...(questions[questionIndex]['answers'] as List<Map>).map((answer) {
          return Answer(() => answerQuestion(answer['score']), answer['text']);
        }).toList(),

        // what's going on above?
        // we need to map through the answers array in each question
        // _questions[_questionIndex]['answers'] isn't recognized by flutter as a List
        // so that's why its wrapped as ( blahblah as List<String>)

        // the thing that is returned by map isn't a list, but a new iterable
        // so that's why the toList() method is called

        // but now you have a list inside a list passed to children prop, which is no good

        // so you convert that to individual props by using the spread operator ( ... )

        // anonymous function pass to first args in Answer constructor because we need
        // to call answerQuestion with a supplied argument.  the anonymous function 
        // will be a function reference, and not a function invocation
      ],
    );
  }
}
