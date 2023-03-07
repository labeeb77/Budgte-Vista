import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_money1/database/transaction/transaction_provider.dart';
import 'package:my_money1/screens/transactoins/slidable_widget.dart';
import 'package:provider/provider.dart';

import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../home/widgets/colors.dart';

class MyTransactions extends StatelessWidget {
  const MyTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<TransactionProvider>(context, listen: false).transactionList;

    return Consumer<TransactionProvider>(
      builder: (context, newList, Widget? _) {
        var showList = [];

        if (newList.categoryNotifier == 'Income') {
          List<TransactionModel> incomeTransactionList = [];
          incomeTransactionList = newList.overViewNotifier
              .where((element) => element.type == CategoryType.income)
              .toList();
          showList = incomeTransactionList;
        } else if (newList.categoryNotifier == 'Expense') {
          List<TransactionModel> expenseTransactionList = [];
          expenseTransactionList = newList.overViewNotifier
              .where((element) => element.type == CategoryType.expense)
              .toList();
          showList = expenseTransactionList;
        } else {
          showList = newList.overViewNotifier;
        }
        return showList.isEmpty
            ? Column(
                children: [
                  const SizedBox(
                    height: 170,
                  ),
                  Center(
                      child: Text('No transaction found',
                          style: GoogleFonts.quicksand(
                              color: ThemeColor.themeColors))),
                ],
              )
            : ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final trValue = showList[index];
                  return SlidableWidget(
                    trValue: trValue,
                    index: index,
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                  );
                },
                itemCount: showList.length);
      },
    );
  }
}
