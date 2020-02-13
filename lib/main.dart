import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/transaction_chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Application',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purpleAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )
         ),
        appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            )),)
        ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
      Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  bool _showChart = false;

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(id){
    setState(() {
      _userTransactions.removeWhere((item) {
        return item.id == id;
      });
    });
  }

  List<Transaction> get _recentTransactions{
    return _userTransactions.where((transaction) {
      print(transaction);
      return transaction.date.isAfter(DateTime.now().subtract(Duration(days:7)));
    }).toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar =  AppBar(
        title: Text('Expenses Application'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
   var appBarStatusBarHeight = appBar.preferredSize.height + mediaQuery.padding.top;
    
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        print(val);
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape) 
            Container( 
              height: (mediaQuery.size.height - appBarStatusBarHeight)  * 0.25,
              child: TransactionChart(_recentTransactions),
            ),
            txListWidget,
            if (isLandscape) 
            _showChart ?
            Container( 
              height: (mediaQuery.size.height - appBarStatusBarHeight)  * 0.75,
               child: TransactionChart(_recentTransactions),
            )
            :
            txListWidget
          ],
        ),
      ),
      floatingActionButtonLocation: isLandscape ? 
      FloatingActionButtonLocation.endFloat
      :
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}

