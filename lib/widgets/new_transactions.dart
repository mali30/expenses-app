import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/**
 * This widget is for when we want to add a new transaction. It contains the TextField where we 
 * enter our title and amount.
 * 
 * Converting to stateful widget going forward. With this change
 * the amount and title don't disappear once you click off of it after 
 * entering the data into the model.
 */
class NewTranscaction extends StatefulWidget {
  final Function addNewTransaction;
  NewTranscaction(this.addNewTransaction);

  @override
  _NewTranscactionState createState() => _NewTranscactionState();
}

class _NewTranscactionState extends State<NewTranscaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty == null) {
      return null;
    }
    final entertedTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (entertedTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    // take the values and pass it to the function.
    widget.addNewTransaction(
      entertedTitle,
      enteredAmount,
      _selectedDate
    );

    // Now we use navigator to close the model.
    // context -> gives navigator metadata. so it knowns what to close
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    // shows datepicker on screen
    // returns a future
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now()
            // function executed once user choices the date
            )
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // lets us input text
                TextField(
                  // customizing the text field
                  decoration: InputDecoration(labelText: "Title"),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Amount"),
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  // we dont use the value but it's their just to make flutter happy
                  // the underscore means we get an argument but we don't care and don't use it
                  onSubmitted: (_) => _submitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      // pushes date picker and date all the way to right and left
                      Expanded(
                        child: Text(_selectedDate == null
                            ? "No Date Chosen"
                            : 'Picked Date :  ${DateFormat.yMd().format(_selectedDate)}'),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          "Choose Date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: _presentDatePicker,
                      )
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text("Add Transaction"),
                  color: Theme.of(context).primaryColor,
                  // gets this color from the theme
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: () => _submitData(),
                ),
              ],
            ),
          )),
    );
  }
}
