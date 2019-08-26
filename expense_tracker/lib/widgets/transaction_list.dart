import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionsList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          // itemBuilder runs this function for every item in itemCount
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  padding: EdgeInsets.all(
                    10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2),
                  ),
                  child: Text(
                    '\$${transactions[index].amount.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.purple),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(transactions[index].title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(DateFormat.yMMMd().format(transactions[index].date),
                        style: TextStyle(color: Colors.grey))
                  ],
                )
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
