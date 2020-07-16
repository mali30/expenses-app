import 'package:expenses_app/widgets/user_transactions.dart';
import 'package:flutter/material.dart';

import './widgets/user_transactions.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return new MaterialApp(
     home: Scaffold(
        appBar: AppBar(
          title: Text("Expenses App"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {}
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Column(
              // most important when using columns and rows
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[UserTransactions()],
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {},
    )
  )
    );
  }
}
