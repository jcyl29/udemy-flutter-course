import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  // final means the value is locked at run time
  // but at declaration the value is unknown
  
  // it is distinct from `const`
  // const means compile time constant
  // i.e. at the time you write the code
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          child: Text(answerText),
          onPressed: selectHandler),
    );
  }
}
