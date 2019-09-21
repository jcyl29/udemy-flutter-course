import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_tracker/models/transaction.dart';

// this code was partially generated by selecting some code,
// Right click, choose Refactor, then choose Extract Widget
// then type name of new Widget

class TransactionItem extends StatefulWidget {
  // StatelessWidgets by themselves don't need a key
  // flutter doesn't need keys default. the default mechiism of identifying widgets by type
  // works most of the time
  // But when you have listview with stateful children, you need keys, use a valueKey, not a uniqueKey
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);  // Constructor initializer list -> this shorthand allows the parent widget/class to calls its own constructor

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple
    ];

    print("availableColors.length=${availableColors.length}");

    _bgColor = availableColors[Random().nextInt(availableColors.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        // leading: widget shows at the beginning of the tile
        // trailing: widgets shows at the end of the tile
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: FittedBox(child: Text('\$${widget.transaction.amount}')),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                textColor: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete),
                // using the const here:
                // this tells flutter that this Text widget will never change, so when widget tree is rebuilt, i.e. when build() of parent
                // widget gets called again,
                // it doesn't have to call build for this Text widget
                label: const Text('Delete'),
                onPressed: () => widget.deleteTx(widget.transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.deleteTx(widget.transaction.id),
              ),
      ),
    );
  }
}
