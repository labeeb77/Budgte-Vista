import 'package:flutter/material.dart';

import '../../viewall/view_all.dart';


class OverViewFilter extends StatelessWidget {
  const OverViewFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
      itemBuilder: (context) => [
        PopupMenuItem(
            value: 1,
            onTap: () => categoryNotifier.value = 'OverView',
            child: const Text('OverView')),
        PopupMenuItem(
            value: 2,
            onTap: () => categoryNotifier.value = 'Income',
            child: const Text('Income')),
        PopupMenuItem(
            value: 3,
            onTap: () => categoryNotifier.value = 'Expense',
            child: const Text('Expense')),
      ],
      child: const Icon(Icons.filter_alt_outlined),
    );
  }
}
