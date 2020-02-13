import 'dart:io';
import 'package:flutter/cupertino.dart';
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

Widget _buildLanscapeContent(){
  return  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Show Chart'),
              Switch.adaptive(
              value: _showChart,
              onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      );
}

List<Widget> _buildPortraitContent(double totalHeight, double appBarStatusBarHeight, Widget txListWidget,){

return [
  Container( 
    height: (totalHeight - appBarStatusBarHeight)  * 0.25,
    child: TransactionChart(_recentTransactions),
  ),
  txListWidget,
  ];
}


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    
    final PreferredSizeWidget appBar = Platform.isIOS ?

    CupertinoNavigationBar(

            middle: Text('Expenses Application'),

            trailing: Row(

              mainAxisSize: MainAxisSize.min,

              children: <Widget>[

                GestureDetector(

                  child: const Icon(CupertinoIcons.add),

                  onTap: () => _startAddNewTransaction(context)

                  )

              ],)

    )

          :

    AppBar(

        title: const Text('Expenses Application'),

        actions: <Widget>[

          IconButton(

            icon: const Icon(Icons.add),

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
    
    var view = SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape)
                 _buildLanscapeContent(),
              if (!isLandscape) 
                 ..._buildPortraitContent(mediaQuery.size.height, appBarStatusBarHeight, txListWidget,),
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
      );
    
      

    return Platform.isIOS ?
        CupertinoPageScaffold(
          navigationBar:appBar,
          child: view,)
          :
        Scaffold(
          appBar: appBar,
          body: view,
          floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
        );
  }
}

