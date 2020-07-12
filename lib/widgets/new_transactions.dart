import 'package:flutter/material.dart';

/**
 * This widget is for when we want to add a new transaction. It contains the TextField where we 
 * enter our title and amount.
 */
class NewTranscaction extends StatelessWidget {
  
  // will get the final output instead of each keystroke
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final Function addNewTransaction;
  NewTranscaction(this.addNewTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
          child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // lets us input text
            TextField(
              // customizing the text field
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
            ),
            FlatButton(
              child: Text("Add Transaction"),
              textColor: Colors.purple,
              onPressed: () {
                addNewTransaction(
                  titleController.text,
                  double.parse(amountController.text),
                );
                print("I was clicked");
              },
            ),
          ],
        ),
      )),
    );
  }
}
