import 'package:flutter/material.dart';

import '../model/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(
      {super.key, required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (BuildContext cntx, BoxConstraints constraints) {
            return Column(
              children: [
                Text(
                  'No Transaction added.',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (cntxt, index) {
              return TransactionItem(
                  transaction: transactions[index],
                  mediaQuery: mediaQuery,
                  transactionIndex: index,
                  deleteTransaction: deleteTransaction);
            },
          );
  }
}
