import 'package:flutter/material.dart';
import 'package:my_money1/database/transaction/transaction_provider.dart';
import 'package:provider/provider.dart';

class DateFilter extends StatelessWidget {
  const DateFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, showValue, child) {
        return PopupMenuButton<int>(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: const Text('All'),
              onTap: () {
                showValue.setOverviewTransaction = showValue.transactionList;
              },
            ),
            PopupMenuItem(
              value: 2,
              child: const Text('Today'),
              onTap: () {
                showValue.setOverviewTransaction = showValue.transactionList
                    .where((element) =>
                        element.date.day == DateTime.now().day &&
                        element.date.month == DateTime.now().month &&
                        element.date.year == DateTime.now().year)
                    .toList();
              },
            ),
            PopupMenuItem(
              value: 2,
              child: const Text('Yesterday'),
              onTap: () {
                showValue.setOverviewTransaction = showValue.transactionList
                    .where((element) =>
                        element.date.day == DateTime.now().day - 1 &&
                        element.date.month == DateTime.now().month &&
                        element.date.year == DateTime.now().year)
                    .toList();
              },
            ),
            PopupMenuItem(
              value: 2,
              child: const Text('Month'),
              onTap: () {
                showValue.setOverviewTransaction = showValue.transactionList
                    .where((element) =>
                        element.date.month == DateTime.now().month &&
                        element.date.year == DateTime.now().year)
                    .toList();
              },
            )
          ],
        );
      },
    );
  }
}
