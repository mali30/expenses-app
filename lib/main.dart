import 'dart:io';

import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'model/transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';

void main() {
  // ensures it works on all devices
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.purple,
          // alternative color
          // fallback color
          accentColor: Colors.amber,
          // color for trash can
          errorColor: Colors.red,
          // using quicksand font globally
          fontFamily: "Quicksand",
          // this is used for any where in the app that wants to use it
          // we use them in our Text() widgets for example for the style
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              button: TextStyle(color: Colors.white)),
          // all text theme in app bar will use this globally
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// list of transactions
final List<Transaction> _transactionList = [];
bool _showChart = false;

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> get _recentTranactionsInLastWeek {
    // lets you run a function on each element in the list
    return _transactionList.where((transactions) {
      return transactions.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

// creates a new transaction
  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTransaction = Transaction(
      title: title,
      amount: amount,
      date: chosenDate,
      uniqueId: DateTime.now().millisecondsSinceEpoch.toString(),
    );

// adding new elements to our list by using setState()
    setState(() {
      _transactionList.add(newTransaction);
    });
  }

// brings up modal for transaction
  void _startProcessOfAddingTransaction(BuildContext context) {
    // context -> gets passed in when widget gets build
    showModalBottomSheet(
        context: context,
        builder: (_) {
          // added this so model doesn't close when it's tapped
          return GestureDetector(
            onTap: () {},
            // widget to show new transaction
            child: NewTranscaction(_addNewTransaction),
            // catch tap event and handle it
            behavior: HitTestBehavior.opaque,
          );
        });
  }

// will delete the transaction based on the id
  void _deleteATransaction(String idOfTransaction) {
    setState(() {
      _transactionList.removeWhere(
          (transaction) => transaction.uniqueId == idOfTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    // put in a variable so I can use everywhere instead of calling directly
    final mediaQuery = MediaQuery.of(context);
    final isLandScapeMode = mediaQuery.orientation == Orientation.landscape;
    // explicitly stating the type since dart can't infert that it has the preferedSize property
    final PreferredSizeWidget appBar = Platform.isIOS ?  CupertinoNavigationBar(
      middle: Text("Expenses App"),
      trailing: Row(
        // row shrinks from left to right as big as it' children
        mainAxisSize: MainAxisSize.min ,
        children: <Widget>[
            GestureDetector(
              child: Icon(
                CupertinoIcons.add
                ),
              onTap: () => _startProcessOfAddingTransaction(context) ,
            ),
      ]),
    )
    : new AppBar(
      title: Text("Personal Expenses"),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startProcessOfAddingTransaction(context)
            ),
      ],
    );

    final listOfTransactions = Container(
        // The list of transactions take up 60% of the screen now
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_transactionList, _deleteATransaction));

    // wrapping in Safe Area which makes sure everything is positioned correclty
    final bodyOfWidget =  SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // most important when using columns and rows
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // checking if in landscape mode
              if (isLandScapeMode)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Show Chart",
                      // manually setting size of text for iOS
                    style: Theme.of(context).textTheme.title),
                    // switch based on platform ios or android
                    Switch.adaptive(
                        value: _showChart,
                        onChanged: (boolValue) {
                          setState(() {
                            _showChart = boolValue;
                          });
                        }),
                  ],
                ), // container for chart
              if (!isLandScapeMode)
                Container(
                    // the chart takes up 70% of the screen height now
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.3,
                    child: Chart(_recentTranactionsInLastWeek)),
              if (!isLandScapeMode)
                listOfTransactions,
              if (isLandScapeMode)
                _showChart
                    ? Container(
                        // the chart takes up 70% of the screen height now
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.7,
                        child: Chart(_recentTranactionsInLastWeek))
                    : listOfTransactions
            ],
          ),
        )
    );
    return  Platform.isIOS ? CupertinoPageScaffold(
      navigationBar: appBar ,
      child: bodyOfWidget
      )
    :  Scaffold(
        appBar: appBar,
        body: bodyOfWidget,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // only show floating button if on android
        floatingActionButton: Platform.isIOS ? 
        Container() :
         FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startProcessOfAddingTransaction(context),
        ));
  }
}
