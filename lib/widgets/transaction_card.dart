import 'package:flutter/material.dart'; 
import 'package:intl/intl.dart';
class TransactionCard extends StatelessWidget {

 final String id;
 final String title;
 final double amount;
 final DateTime date;
 final Function deleteItem;

  TransactionCard({
    @required Key key,
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
    @required this.deleteItem
  });
  
  @override
  Widget build(BuildContext context) {

    final curScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Card(
        child: Row(children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal:15,
              vertical: 20
              ),
            padding: const EdgeInsets.all(2),
            height: 70,
            width: 70,
            child:CircleAvatar(
                radius: 60,
                child: Padding(
                padding: const EdgeInsets.all(10),
                child: FittedBox(
                child: Text('£ ${amount.toStringAsFixed(2)}',style: TextStyle(fontSize: 18 * curScaleFactor, fontWeight: FontWeight.bold))),
              ),
            ),
          ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                margin: const EdgeInsets.symmetric(
                horizontal:2,
                vertical: 10,
              ),
              height: 20,
              width: 200,
              child:Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ),
              Text(DateFormat.yMEd().format(date), style: TextStyle(fontSize: 12 * curScaleFactor, color: Colors.blueGrey)),
            ],),
            IconButton(
             icon: const Icon(Icons.delete),
             onPressed: (){deleteItem(id);},
            ),
        ],)
      );
  }
}