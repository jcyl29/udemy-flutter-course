import 'package:flutter/material.dart';

class TextOutput extends StatelessWidget {
  final List<String> textList;
  final int textIndex;

  TextOutput(this.textList, this.textIndex);

  @override
  Widget build(BuildContext context) {
    return Text(textList[textIndex]);
  }
}
