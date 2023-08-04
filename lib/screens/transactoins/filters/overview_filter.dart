import 'package:flutter/material.dart';
import 'package:my_money1/database/transaction/transaction_provider.dart';
import 'package:provider/provider.dart';

class OverViewFilter extends StatelessWidget {
  const OverViewFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, showvalue, child) {
        return PopupMenuButton(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          itemBuilder: (context) => [
            PopupMenuItem(
                value: 1,
                onTap: () => showvalue.setShowCategory = 'OverView',
                child: const Text('OverView')),
            PopupMenuItem(
                value: 2,
                onTap: () => showvalue.setShowCategory = 'Income',
                child: const Text('Income')),
            PopupMenuItem(
                value: 3,
                onTap: () => showvalue.setShowCategory = 'Expense',
                child: const Text('Expense')),
          ],
          child: const Icon(Icons.filter_alt_outlined),
        );
      },
    );
  }
}
