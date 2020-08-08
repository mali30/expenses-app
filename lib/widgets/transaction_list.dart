import 'package:expenses_app/model/transaction.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

/**
 * This widget is for displaying the list of transactions we have
 */
class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  Function deleteATransactionFromList;

  TransactionList(this.transaction, this.deleteATransactionFromList);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: transaction.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Column(
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
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover),
                    )
                  ],
                );
              })
            :
            // here we display the list if we have transactions
            // remember listView has
            ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    elevation: 5,
                    child: ListTile(
                      // widget thats position at the beginning
                      leading: CircleAvatar(
                          // how round it is
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text('\$${transaction[index].amount}'),
                            ),
                          )),
                      title: Text(
                        transaction[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      // text shown below the title
                      subtitle: Text(
                          DateFormat.yMMMd().format(transaction[index].date)),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        // wrap into anonymous function since it takes an argument
                        onPressed: () => deleteATransactionFromList(
                            transaction[index].uniqueId),
                      ),
                    ),
                  );
                  /**
                 * What we are gonna do now is transition to using a ListTitle() widget
                 * This works great when you need to use lists and it comes pre-configured
                 * gonna leave this here just for reference.
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
                        '${transaction[index].amount}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transaction[index].title,
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
                 */
                },
                // gives us the length of the items.
                itemCount: transaction.length,
              ));
  }
}
