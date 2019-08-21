import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  // `final`: this tell dart that this value will never change
  // after its initialization in the constructor
  final String questionText;

  // constructor
  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
