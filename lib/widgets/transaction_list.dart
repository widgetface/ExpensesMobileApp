import 'package:flutter/material.dart';
import './transaction_card.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);
 
  @override
  Widget build(BuildContext context) {
    return (
      transactions.isEmpty ?
      Column(
        children: <Widget>[
          Text(
            'No transactions added yet ',
            style: Theme.of(context).textTheme.title,
          ),
          Container(
            height: 200,
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
            child: Image.asset('assets/images/waiting.png', fit:BoxFit.cover),
          ),
        ],)
        :
        ListView.builder(
        itemBuilder: (ctx, index) {
          return TransactionCard(
              id: transactions[index].id,
              title: transactions[index].title,
              amount: transactions[index].amount,
              date: transactions[index].date,
              deleteItem: deleteTransaction,
          );
        },
        itemCount: transactions.length,
      )
    );
  }
}
