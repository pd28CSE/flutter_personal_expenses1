import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import '../model/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
              width: 3,
            ),
          ),
        ),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.green,
        //     side: BorderSide(color: Colors.yellow, width: 5),
        //     textStyle: TextStyle(
        //         color: Colors.white, fontSize: 25, fontStyle: FontStyle.italic),
        //   ),
        // ),
      ),
      title: 'My App',
      home: _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  _Home({super.key});

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  // String? _titleInput;

  final List<Transaction> _transactions = [
    Transaction(title: 'title 1', amount: 5545, date: DateTime.now()),
    Transaction(title: 'title 2', amount: 546, date: DateTime.now()),
    Transaction(
        title: 'title 3',
        amount: 5457,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(title: 'title 4', amount: 548, date: DateTime.now()),
    Transaction(title: 'title 5', amount: 549, date: DateTime.now()),
    Transaction(title: 'title 1', amount: 545, date: DateTime.now()),
    Transaction(title: 'title 2', amount: 546, date: DateTime.now()),
    Transaction(title: 'title 3', amount: 547, date: DateTime.now()),
    Transaction(title: 'title 4', amount: 548, date: DateTime.now()),
    Transaction(title: 'title 5', amount: 549, date: DateTime.now()),
  ];
  bool _showChart = false;

  void _addNewTransaction(String nwTitle, double nwAmount, DateTime nwDate) {
    final Transaction nwTransaction =
        Transaction(title: nwTitle, amount: nwAmount, date: nwDate);

    setState(() {
      _transactions.add(nwTransaction);
    });
  }

  void startAddNewTransaction(BuildContext cntxt) {
    showModalBottomSheet(
      context: cntxt,
      builder: (_) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: NewTransaction(
            addNewTransaction: _addNewTransaction,
          ),
        );
      },
    );
  }

  void _deleteTransaction(int index) {
    setState(() {
      _transactions.removeAt(index);
    });
  }

  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('App Bar'),
      // titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
      //       color: Colors.amber,
      //     ),
      actions: [
        IconButton(
          onPressed: () {
            startAddNewTransaction(context);
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
    final txListWidget = Container(
      height: (MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              appBar.preferredSize.height) *
          0.7,
      child: TransactionList(
          transactions: _transactions, deleteTransaction: _deleteTransaction),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_showChart == false ? 'Show Chart' : 'Hide Chart'),
                  Switch(
                      // activeTrackColor: Colors.grey,
                      // inactiveTrackColor: Colors.red,
                      // activeColor: Colors.blue,
                      // inactiveThumbColor: Colors.green,
                      value: _showChart,
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      }),
                ],
              ),
            if (isLandscape == false)
              Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        appBar.preferredSize.height) *
                    0.3,
                child: Chart(recentTransactions: _transactions),
              ),
            if (isLandscape == false) txListWidget,
            if (isLandscape == true)
              _showChart == true
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top -
                              appBar.preferredSize.height) *
                          0.7,
                      child: Chart(recentTransactions: _transactions),
                    )
                  : txListWidget,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
