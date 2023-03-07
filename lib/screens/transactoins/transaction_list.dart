// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:my_money1/screens/transactoins/slidable_widget.dart';


// import '../../database/transaction/transaction_db.dart';
// import '../../models/category/category_model.dart';
// import '../../models/transaction/transaction_model.dart';
// import '../home/widgets/colors.dart';
// import '../viewall/view_all.dart';

// ValueNotifier<List<TransactionModel>> overViewNotifier =
//     ValueNotifier(TransactionsDB.instance.transactionListNotfier.value);

// class MyTransactions extends StatelessWidget {
//   const MyTransactions({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//         valueListenable: TransactionsDB.instance.transactionListNotfier,
//         builder: (context, transactionList, _) {
//           return ValueListenableBuilder(
//             valueListenable: overViewNotifier,
//             builder: (context, newList, Widget? _) {
//               return ValueListenableBuilder(
//                 valueListenable: categoryNotifier,
//                 builder: (context, categoryList, child) {
//                   var showList = [];

//                   if (categoryNotifier.value == 'Income') {
//                     List<TransactionModel> incomeTransactionList = [];
//                     incomeTransactionList = newList
//                         .where((element) => element.type == CategoryType.income)
//                         .toList();
//                     showList = incomeTransactionList;
//                   } else if (categoryNotifier.value == 'Expense') {
//                     List<TransactionModel> expenseTransactionList = [];
//                     expenseTransactionList = newList
//                         .where(
//                             (element) => element.type == CategoryType.expense)
//                         .toList();
//                     showList = expenseTransactionList;
//                   } else {
//                     showList = newList;
//                   }
//                   return showList.isEmpty
//                       ? Column(
//                           children: [
//                             const SizedBox(
//                               height: 170,
//                             ),
//                             Center(
//                                 child: Text('No transaction found',
//                                     style: GoogleFonts.quicksand(
//                                         color: ThemeColor.themeColors))),
//                           ],
//                         )
//                       : ListView.separated(
//                           scrollDirection: Axis.vertical,
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) {
//                             final trValue = showList[index];
//                             return SlidableWidget(
//                               trValue: trValue,
//                               index: index,
//                             );
//                           },
//                           separatorBuilder: (context, index) {
//                             return const Divider(
//                               height: 1,
//                             );
//                           },
//                           itemCount: showList.length);
//                 },
//               );
//             },
//           );
//         });
//   }
// }
