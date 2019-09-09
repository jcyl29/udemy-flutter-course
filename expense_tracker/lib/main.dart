import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        // difference between swatch and color
        // color is just a single color
        // if you define a swatch, flutter widgets will know how to
        // pick different shades of the color specififed
        primarySwatch: Colors.purple,
        // accentSwatch doesn't exist
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          // this is a way to set the appBarTheme to have custom TextStyle
          // (light font, different font family, etc)
          // for all the titles of appBarTheme
          // this will become useful when your app has multiple pages
          // and you don't want to have to declare them in every page
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 30,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'new shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'weekly grocedddries',
    //     amount: 16.53,
    //     date: DateTime.now())
  ];

  List<Transaction> get _recentTranscations {
    // where == array.filter in javascript
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          // builder callback has a context argument, but don't use it, thus the _
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            // onTap: () {},
            // behavior: HitTestBehavior.opaque, // to catch the tap event and avoid it being handled by anyone else
            // the following above commented code was needed to prevent tapping the modal itself will close modal
            // it is not happening anymore
          );
        });
  }

  void _deleteTransaction(String txId) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == txId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Personal Expenses',
      ),
      actions: <Widget>[
        // normally add buttons in actions property of Scaffold
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Column only takes as much width as its child elements need
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(_recentTranscations)),
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.7,
                  child:
                      TransactionsList(_userTransactions, _deleteTransaction)),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

// the full height of the device contains
// Status Bar (MediaQuery.of(context).padding.top)
// AppBar
// Chart
// TransactionList
