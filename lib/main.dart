import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'model/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses", 
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // alternative color
        // fallback color
        accentColor: Colors.amber, 
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // list of transactions
  final List<Transaction> _transactionList = [];

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
            title: Text("Personal Expenses"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startProcessOfAddingTransaction(context)),
            ],
          ),
          body: ListView(
            children: <Widget>[
              Column(
                // most important when using columns and rows
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[TransactionList(_transactionList)],
              ),
            ],
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
