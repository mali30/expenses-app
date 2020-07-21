import 'package:expenses_app/model/transaction.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

/**
 * This widget is for displaying the list of transactions we have
 */
class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;

  TransactionList(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: transaction.isEmpty
            ? Column(
                // loop through the list of transactions
                children: <Widget>[
                  Text(
                    "No transactions added yet",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  // will add space between text and picture
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    /*
                In order to make image smaller for smaller screen, wrapped 
                the image in a container and set the height.
                */
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                        fit: BoxFit.cover
                        ),
                  )
                ],
              )
            : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                    child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30
                        ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              // using the color that's passed down into the context by parent widget (main)
                              color: Theme.of(context).primaryColor,
                              width: 2)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        // limits to two decimals places
                        '${transaction[index].amount.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transaction[index].amount.toString(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          DateFormat().format(transaction[index].date),
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                              ),
                        )
                      ],
                    )
                  ],
                )
                );
              },
              itemCount: transaction.length,
              )
            );
  }
}
