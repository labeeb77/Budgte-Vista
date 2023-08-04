import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_money1/database/transaction/transaction_provider.dart';
import 'package:my_money1/screens/transactoins/slidable_widget.dart';
import 'package:provider/provider.dart';

import '../home/widgets/colors.dart';

class RecentTransaction extends StatelessWidget {
  const RecentTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, newList, child) {
        return newList.transactionList.isEmpty
            ? Center(
                child: Text('No transactions found',
                    style:
                        GoogleFonts.quicksand(color: ThemeColor.themeColors)),
              )
            : Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final trValue = newList.transactionList[index];
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
                    itemCount: newList.transactionList.length > 3
                        ? 3
                        : newList.transactionList.length),
              );
      },
    );
  }
}
