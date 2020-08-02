import 'package:expenses_app/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';
import '../widgets/chart_bar.dart';

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
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
      // gives us reversed list 
    }).reversed.toList();
  }

  double get maxSpending {
    // changes a list to another type based on logic passed into the function
    // first paramter is initial value
    // second argument is the currently calculated sum
    // third is the element we are looking
    return groupedTransactionsValues.fold(0.0, (sum, currElement) {
      return sum + currElement['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      // if you only need padding, dont wrap with Container
      // instead use Padding
      child: Padding(
        padding: EdgeInsets.all(10),
              child: Row(
          // adds space between bars
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // widget for bar is created here
          children: groupedTransactionsValues.map((data) {
            return Flexible(
              // makes child have same space
              fit: FlexFit.tight,
                        child: ChartBar(
                   data['day'],
                   data['amount'],
                   // this was causing an error since if we don't have any transactions
                   // we divide by 0 which is invalid
                  maxSpending == 0.0 ? 0.0 : (data['amount'] as double) / maxSpending),
            );
          }).toList(),
          // holds the 7 bars for the days
        ),
      ),
    );
  }
}
