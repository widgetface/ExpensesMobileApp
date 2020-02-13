import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar({
    this.label, 
    this.spendingAmount, 
    this.spendingPctOfTotal
  });

  @override
  Widget build(BuildContext context) {
        final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child:FittedBox(
          child: Text('\£${spendingAmount.toStringAsFixed(0)}', style: TextStyle(fontSize: 18 * curScaleFactor,)),
          ), 
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label,  style: TextStyle(fontSize: 16 * curScaleFactor,)),
      ],
    );
  }
}