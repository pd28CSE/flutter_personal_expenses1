import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

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
              return Card(
                elevation: 4,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(0)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle:
                      Text(DateFormat.yMEd().format(transactions[index].date)),
                  trailing: mediaQuery.size.width > 500
                      ? TextButton.icon(
                          onPressed: () {
                            deleteTransaction(index);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                          label: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteTransaction(index),
                        ),
                ),
              );
            },
          );
  }
}
