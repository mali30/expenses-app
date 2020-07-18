/**
 * Not needed anymore since we manage state in main 
 * because we use the floatingAcionButton to add new transactions
 */

// import 'package:flutter/material.dart';

// import './new_transactions.dart';
// import './transaction_list.dart';
// import '../model/transaction.dart';

// /**
//  * This widget is for managing the state for when new transactions are added
//  */
// class UserTransactions extends StatefulWidget {
//   @override
//   _UserTransactionsState createState() => _UserTransactionsState();
// }

// class _UserTransactionsState extends State<UserTransactions> {
//   // list of transactions
//   final List<Transaction> _transactionList = [];

// // creates a new transaction
//   void _addNewTransaction(String title, double amount) {
//     final newTransaction = Transaction(
//         title: title,
//         amount: amount,
//         date: DateTime.now(),
//         uniqueId: DateTime.now().millisecondsSinceEpoch.toString());

// // adding new elements to our list by using setState()
//     setState(() {
//       _transactionList.add(newTransaction);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//     // passing pointer of method to create a new transaction and add to list down to NewTransaction widget
//         NewTranscaction(_addNewTransaction),
//         // TransactionList(_transactionList)
//       ],
//     );
//   }
// }
