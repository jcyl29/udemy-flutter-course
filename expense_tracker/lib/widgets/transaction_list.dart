import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionsList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print("build() TransactionList");
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transaction added yet',
                    style: Theme.of(context).textTheme.title,
                  ),
                  const SizedBox(
                    height: 20, // it is being used a seperator in this case
                  ),
                  Container(
                      height: constraints.maxHeight * .5,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit
                            .cover, // fit won't work with Column by itself, because Column takes as much room as the content inside it
                      )),
                ],
              );
            },
          )
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                    key: ValueKey(tx.id), transaction: tx, deleteTx: deleteTx))
                .toList());
  }
}
