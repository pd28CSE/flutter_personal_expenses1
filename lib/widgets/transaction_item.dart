import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.mediaQuery,
    required this.transactionIndex,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final int transactionIndex;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                '\$${transaction.amount.toStringAsFixed(0)}',
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat.yMEd().format(transaction.date)),
        trailing: mediaQuery.size.width > 500
            ? TextButton.icon(
                onPressed: () {
                  deleteTransaction(transactionIndex);
                },
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteTransaction(transactionIndex),
              ),
      ),
    );
  }
}
