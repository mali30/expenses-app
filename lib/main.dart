import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:flutter/material.dart';
import 'model/transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // alternative color
        // fallback color
        accentColor: Colors.amber,
        // using quicksand font globally
        fontFamily: "Quicksand",
        // this is used for any where in the app that wants to use it
        // we use them in our Text() widgets for example for the style 
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
            fontSize: 20
          )
        ),
        // all text theme in app bar will use this globally
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans', fontSize: 20,
              fontWeight: FontWeight.bold
                  )
                )
              )
      ),
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
  void _addNewTransaction(String title, double amount) {
    final newTransaction = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        uniqueId: DateTime.now().millisecondsSinceEpoch.toString());

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
              child: NewTranscaction(_addNewTransaction),
              // catch tap event and handle it
              behavior: HitTestBehavior.opaque,
              );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: new AppBar(
            title: Text(
              "Personal Expenses"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startProcessOfAddingTransaction(context)),
            ],
          ),
            body: SingleChildScrollView( 
                    child: Column(
                  // most important when using columns and rows
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Chart(_recentTranactionsInLastWeek),
                    TransactionList(_transactionList)
                    ],
                ),
              ),  
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startProcessOfAddingTransaction(context),
        )
    );
    
  }
}
