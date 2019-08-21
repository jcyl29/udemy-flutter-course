import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

// void main() {
//   runApp(MyApp());
// }

// arrow function version of above
void main() => runApp(MyApp());

// flutter calls build method.  flutter also expects your app to inherit a stateless or stateful widget
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;

  final _questions = const [
    {
      'questionText': 'What\'s your favorite color',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1}
      ],
    },
    {
      'questionText': 'What\'s your favorite GAN MA animal',
      'answers': [
        {'text': 'rabbit', 'score': 2},
        {'text': 'snake', 'score': 1},
        {'text': 'elephant', 'score': 4},
        {'text': 'fox', 'score': 1}
      ],
    },
    {
      'questionText': 'who\'s your favorite instructor',
      'answers': [
        {'text': 'Max', 'score': 0},
        {'text': 'Max', 'score': 0},
        {'text': 'Max', 'score': 0},
      ],
    },
  ];

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    // setState calls build method
    // flutter figures out what got changed and doesn't repaint everything in the widget
    // like React and Virtual DOM
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    print("_questionIndex=" +
        _questionIndex.toString() +
        ",_questions.length=" +
        _questions.length.toString());
    if (_questionIndex < _questions.length) {
      print("we have more questions");
    }
  }

  // @override is a decorator to explicitly say the build method will be overriden
  // this syntax is optional but is good practice
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App, A Quiz'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
