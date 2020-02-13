import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if(_amountController.text.isEmpty) return;
 
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) return ;
    
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
// close the modal 
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
      showDatePicker(
      context: context, 
      initialDate: DateTime.now() , 
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now()
      ).then((selectedDate) {
          if(selectedDate == null) return;
          setState((){
          _selectedDate = selectedDate;
          });
      });


  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( 
      child: Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            Container(
              height: 50,
              margin:EdgeInsets.symmetric(
                vertical: 10, 
                horizontal: 2
                ),
              child:  Row(
              children: <Widget>[
                Expanded(
                  child:  Text(_selectedDate == null ? 
                        'No Date Chosen'
                        :
                        DateFormat.yMEd().add_jms().format(_selectedDate)
                      ),
                    ),
                  FlatButton(
                  autofocus: true,
                  child: Text('Choose date'),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _showDatePicker,
                  ),
                ],
              ),
            ),
           
            FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(6.0),
                    side: BorderSide(color: Theme.of(context).primaryColor)
                  ),
              child: Text('Add Transaction'),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    ),
    );
  }
}
