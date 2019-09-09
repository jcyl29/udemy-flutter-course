import 'package:flutter/material.dart';

class Chartbar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctofTotal;

  Chartbar(this.label, this.spendingAmount, this.spendingPctofTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Container(
            // this will forced the price label to have a consistent height
            //since large number amounts will be shrunk by FittedBox and take up less space
            height: constraints.maxHeight * .15,
            child: FittedBox(
              // this will take care of really large amount values.  the text will be shrunk to fix in the box
              child: Text(
                '\$${spendingAmount.toStringAsFixed(0)}',
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * .05,
          ),
          Container(
            height: constraints.maxHeight *
                .6, //the max height the chartBar might take
            width: 10,
            child: Stack(
              // a stack widget lets you "stack" elements along the z-axis. think of using z-index in css
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  // this widget is stacked above the sibling Container, and since its height is less the height of the parent Container
                  // (60), you will still see the sibling Container behind it.
                  heightFactor: spendingPctofTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * .05,
          ),
          Container(
              height: constraints.maxHeight * .15,
              child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
