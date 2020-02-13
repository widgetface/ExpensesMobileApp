import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import './chart_bar.dart';
import '../models/transaction.dart';

class TransactionChart extends StatelessWidget {

  final List<Transaction> recentTransactions;

  TransactionChart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
       final weekDay = DateTime.now().subtract(Duration(days: index), );
       var currentDay = weekDay.day;
       double totalSpend = 0.00;
        

      for(var transaction in this.recentTransactions){
        if( transaction.date.day == currentDay){
          if(transaction.amount != null){
              totalSpend = totalSpend + transaction.amount;
          }
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSpend,
      };
    }).reversed.toList();
  }

  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum, item) {
        return sum += item['amount'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
     child: Container(
       padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((data){
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'], 
                spendingAmount: data['amount'], 
                spendingPctOfTotal: (data['amount'] as double)/totalSpending
                ));
          }).toList()
        ),
       )
    );
  }
}