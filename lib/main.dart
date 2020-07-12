import 'package:expenses_app/widgets/user_transactions.dart';
import 'package:flutter/material.dart';

import './widgets/user_transactions.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatelessWidget {
  String titleInput;
  String amountInput;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: new Scaffold(
            appBar: AppBar(title: Text("Hello Here")),
            body: Column(
              // most important when using columns and rows
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                UserTransactions()
              ],
            )));
  }
}
