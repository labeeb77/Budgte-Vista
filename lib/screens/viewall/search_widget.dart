// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:my_money1/database/transaction/transaction_provider.dart';
// import 'package:provider/provider.dart';



// import '../../models/transaction/transaction_model.dart';
// import '../transactoins/slidable_widget.dart';

// class SearchTransaction extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: () {
//             query = '';
//           },
//           icon: const Icon(Icons.clear))
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     IconButton(
//         onPressed: () {
//           close(context, null);
//         },
//         icon: const Icon(Icons.arrow_back_ios));
//     return null;
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     Provider.of<TransactionProvider>(context,listen: false).refresh();
//     return Consumer(
//       valueListenable: TransactionsDB.instance.transactionListNotfier,
//       builder:
//           (BuildContext context, List<TransactionModel> newList, Widget? _) {
//         List<TransactionModel> transaction = [];
//         transaction = newList
//             .where(
//               (element) => element.category.name.toLowerCase().contains(
//                     query.toLowerCase(),
//                   ),
//             )
//             .toList();

//         return transaction.isEmpty
//             ? const Center(
//                 child: Text('no data found'),
//               )
//             : ListView.separated(
//                 itemBuilder: ((context, index) {
//                   return SlidableWidget(
//                       trValue: transaction[index], index: index);
//                 }),
//                 itemCount: newList.length,
//                 separatorBuilder: (context, index) {
//                   return const Divider(
//                     height: 2,
//                   );
//                 },
//               );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: TransactionsDB.instance.transactionListNotfier,
//       builder:
//           (BuildContext context, List<TransactionModel> newList, Widget? _) {
//         List<TransactionModel> transaction = [];
//         transaction = newList
//             .where(
//               (element) => element.category.name.toLowerCase().contains(
//                     query.toLowerCase(),
//                   ),
//             )
//             .toList();

//         return transaction.isEmpty
//             ? const Center(
//                 child: Text('no data found'),
//               )
//             : ListView.separated(
//                 itemBuilder: ((context, index) {
//                   return SlidableWidget(
//                       trValue: transaction[index], index: index);
//                 }),
//                 itemCount: newList.length,
//                 separatorBuilder: (context, index) {
//                   return const Divider(
//                     height: 2,
//                   );
//                 },
//               );
//       },
//     );
//   }

//   String parseDate(DateTime date) {
//     return DateFormat.yMMMEd().format(date);
//   }
// }
