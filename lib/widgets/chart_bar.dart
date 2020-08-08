import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentage;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
          children: <Widget>[
            // forces child into avialble space
            // in our case makes text keep original size
            Container(
                // max height chart bar can take
                height: constraint.maxHeight * 0.15,
                child: FittedBox(
                    child: Text('\$${spendingAmount.toStringAsFixed(2)}'))),
            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            Container(
              height: constraint.maxHeight * 0.6,
              width: 10,
              // allows you to place elements on top of each other
              // really overlapping
              child: Stack(
                children: <Widget>[
                  // bottom most widget
                  // represents all of the 7 containers we see for bars
                  Container(
                      decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20),
                  )),
                  // represents the bar that fills up purple when passing in transactions
                  FractionallySizedBox(
                      heightFactor: spendingPercentage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ))
                ],
              ),
            ),
            // represents the little space between the day and the bar
            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            // the day of the week
            Container(
                height: constraint.maxHeight * 0.15,
                child: FittedBox(child: Text(label)))
          ],
        );
      },
    );
  }
}
