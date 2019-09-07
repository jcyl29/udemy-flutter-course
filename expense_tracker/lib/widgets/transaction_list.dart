import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionsList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transaction added yet',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,  // it is being used a seperator in this case
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit
                          .cover, // fit won't work with Column by itself, because Column takes as much room as the content inside it
                    )),
              ],
            )
          : ListView.builder(
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
                          border: Border.all(
                            // context has metadata about a widget.  It also has a way to accces
                            // Theme object even though it is declared all the way up in
                            // the main.dart
                            color: Theme.of(context).primaryColorLight,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          // this is like the backtick string interpolation syntax in es6 javascript
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Quicksand',
                            ),
                          ),
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
