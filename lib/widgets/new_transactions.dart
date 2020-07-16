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

  void submitData() {
    final entertedTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (entertedTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    addNewTransaction(
      entertedTitle,
      enteredAmount,
    );
  }

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
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              // we dont use the value but it's their just to make flutter happy
              // the underscore means we get an argument but we don't care and don't use it
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              child: Text("Add Transaction"),
              textColor: Colors.purple,
              onPressed: () => submitData,
            ),
          ],
        ),
      )),
    );
  }
}
