import 'package:expenses_app/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

/*
  Basic Chart
*/
class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    /* creates a list of values. starts from 0 and goes to 6
     represents monday - sunday
     method will tell us which transactions were generated for each day
     index -> 0-6
    */
    return List.generate(7, (index) {
      /*
        we need to find out the day of the week
        and for each day get the total transactions
      */
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        // comparing by day, week, and month
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year)
          totalSum += recentTransactions[i].amount;
      }

      // print(DateFormat.E().format(weekDay));
      /*
       dateFormat.E() gives us shortcut for the weekday
      */
      return {'day': DateFormat.E().format(weekDay), "amount": totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[],
        // holds the 7 bars for the days
      ),
    );
  }
}
