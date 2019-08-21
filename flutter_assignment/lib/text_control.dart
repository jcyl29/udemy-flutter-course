import 'package:flutter/material.dart';
import 'dart:math';

import './text_output.dart';

class TextControl extends StatefulWidget {  
  @override
  _TextControlState createState() => _TextControlState();
}

class _TextControlState extends State<TextControl> {
 final _junkyText = const ["Running", "Grab", "Impact"];
  var _textIndex = 0;

  var _random = new Random();
  //
  // Generates a positive random integer uniformly distributed on the range
  // from [min], inclusive, to [max], exclusive.
  //
  int next(int min, int max) => min + _random.nextInt(max - min);

  void _shuffleText() {
    setState(() {
      _textIndex = next(0, _junkyText.length);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextOutput(_junkyText, _textIndex),
        RaisedButton(
          child: Text("Shuffle text above"),
          onPressed: _shuffleText,
        )
      ],
    );
  }
}
