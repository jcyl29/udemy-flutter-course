import 'dart:io';

import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // application or system wise settings
  // make the app show in portrait mode only

  // requires this import:
  // import 'package:flutter/services.dart';

  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

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

// the `with` syntax is a called a mixin
// https://medium.com/flutter-community/https-medium-com-shubhamhackzz-dart-for-flutter-mixins-in-dart-f8bb10a3d341
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'new shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'weekly grocedddries',
    //     amount: 16.53,
    //     date: DateTime.now())
  ];
  bool _showChart = false;

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

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  
  // didChangeAppLifecycleState came from WidgetsBindingObserver
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // example logging when tapping context switch button when app is open
  // I/flutter (17874): AppLifecycleState.inactive
  // D/EGL_emulation(17874): eglMakeCurrent: 0x9b40b320: ver 2 0 (tinfo 0x8b7e3870)
  // I/flutter (17874): AppLifecycleState.paused

  // example logging after tapping the app again to bring it back into focus
  // I/flutter (17874): AppLifecycleState.paused
  // I/flutter (17874): AppLifecycleState.inactive
  // I/flutter (17874): AppLifecycleState.resumed

  // example logging when closing the app
  // D/EGL_emulation(17874): eglCreateContext: 0x9fb85360: maj 2 min 0 rcv 2
  // D/EGL_emulation(17874): eglMakeCurrent: 0x9fb85360: ver 2 0 (tinfo 0x9fb832c0)
  // D/EGL_emulation(17874): eglMakeCurrent: 0x9b40b320: ver 2 0 (tinfo 0x8b7e3870)
  // D/EGL_emulation(17874): eglMakeCurrent: 0x9fb85360: ver 2 0 (tinfo 0x9fb832c0)
  // I/flutter (17874): AppLifecycleState.inactive
  // D/EGL_emulation(17874): eglMakeCurrent: 0x9b40b320: ver 2 0 (tinfo 0x8b7e3870)
  // I/flutter (17874): AppLifecycleState.paused
  // Lost connection to device.
  // Exited (sigterm)  


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

  // example of a builder method
  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, var appBar, Widget txListWidget) {
    // using `var` as the type returned by appBar since it could be AppBar for Android
    // or CupertinoNavigationBar for iOS
    // basically i want the appBar to be restricted to 2 types.  This is called a union type
    // and dart doesn't support it.  See:
    // https://stackoverflow.com/questions/53236840/is-there-a-way-to-have-an-argument-with-two-types-in-dart
    // https://github.com/dart-lang/sdk/issues/4938
    // https://pub.dev/packages/sealed_unions
    // just going to keep to just var for now
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.title,
          ),
          Switch.adaptive(
            // .adaptive will show IOS switch or Android switch automagically
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTranscations))
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, var appBar, Widget txListWidget) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTranscations),
      ),
      txListWidget
    ];
  }

  PreferredSizeWidget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              // if you don't set this mainAxisSize property, the trailing part of this widget, i.e. the one with the plus icon
              // will take up the entire space of the screen.  that's why you don't see text from "middle" prop
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // IconButton is a Material-specific widget.  It does not exist
                // for Cupertino.  So GestureDetector is a replacement for IconButton
                // for now until flutter releases a Cupertino-equivalent for IconButton
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
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
  }

  @override
  Widget build(BuildContext context) {
    print("build() MyHomePageState");

    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _buildAppBar();
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          1.0,
      child: TransactionsList(
        _userTransactions,
        _deleteTransaction,
      ),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
            // Column only takes as much width as its child elements need
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // this is special if syntax, i.e. an if inside a list.  it doesn't need braces ({})
              // inside the if block
              if (isLandscape)
                ..._buildLandscapeContent(mediaQuery, appBar, txListWidget),
              if (!isLandscape)
                // using spread operator (...) to flatten out the List<Widget> that _buildPortraitContent returns
                ..._buildPortraitContent(mediaQuery, appBar, txListWidget),
            ]),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}

// the full height of the device contains
// Status Bar (mediaQuery.padding.top)
// AppBar
// Chart
// TransactionList
