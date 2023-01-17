import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../model/transaction.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;

  Chart({super.key, required this.recentTransactions});

  List<Map<String, Object>> get groupedTranslationValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  double get totalSpending {
    return groupedTranslationValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...groupedTranslationValues.map((transaction) {
              return Expanded(
                child: ChartBar(
                  label: (transaction['day'] as String),
                  sepndingAmount: (transaction['amount'] as double),
                  sepndingPctOfTotal: totalSpending == 0
                      ? 0.0
                      : (transaction['amount'] as double) / totalSpending,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
