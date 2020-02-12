import 'package:flutter/material.dart';


class TransactionInput extends StatelessWidget {

Function onClick;
// get values from TextFiled inputs
final titleController = TextEditingController();
final amountController = TextEditingController();

TransactionInput(this.onClick);


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          margin: EdgeInsets.symmetric(
              horizontal:10,
              vertical: 20
        ),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Enter Item Name'
               ),
               controller: titleController,
            ),
                     TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Enter Item Name'
               ),
               controller: amountController,
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: () {
                onClick(titleController.text, amountController.text);
              },
              )
          ]
          ,)
      ),
    );
  }
}