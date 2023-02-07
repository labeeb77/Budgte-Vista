import 'package:flutter/material.dart';

import '../../../database/transaction/transaction_db.dart';
import '../transaction_list.dart';


class DateFilter extends StatelessWidget {
  const DateFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: const Text('All'),
          onTap: () {
            overViewNotifier.value =
                TransactionsDB.instance.transactionListNotfier.value;
          },
        ),
        PopupMenuItem(
          value: 2,
          child: const Text('Today'),
          onTap: () {
            overViewNotifier.value = TransactionsDB
                .instance.transactionListNotfier.value
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
            overViewNotifier.value = TransactionsDB
                .instance.transactionListNotfier.value
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
            overViewNotifier.value = TransactionsDB
                .instance.transactionListNotfier.value
                .where((element) =>
                    element.date.month == DateTime.now().month &&
                    element.date.year == DateTime.now().year)
                .toList();
          },
        )
      ],
    );
  }
}
