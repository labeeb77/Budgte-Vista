import 'package:flutter/material.dart';
import 'package:my_money1/database/transaction/transaction_provider.dart';
import 'package:provider/provider.dart';

class SearchAll extends StatelessWidget {
  const SearchAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22, top: 25, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 15,
              spreadRadius: 1,
              offset: const Offset(5, 5),
            ),
            const BoxShadow(
              color: Colors.white70,
              blurRadius: 15,
              spreadRadius: 1,
              offset: Offset(-5, -5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) => displayResults(value, context),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Search',
              suffixIcon: Icon(
                Icons.search_rounded,
                color: Colors.black38,
                size: 30,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  displayResults(String query, BuildContext context) {
    if (query.isEmpty) {
      context.read<TransactionProvider>().overViewNotifier =
          context.read<TransactionProvider>().transactionList;
      context.read<TransactionProvider>().notifyListeners();
    } else {
      context.read<TransactionProvider>().overViewNotifier = context
          .read<TransactionProvider>()
          .transactionList
          .where(
            (element) =>
                element.category.name
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                element.category.name
                    .toUpperCase()
                    .contains(query.toUpperCase()) ||
                element.notes.toLowerCase().contains(query.toLowerCase()) ||
                element.notes.toUpperCase().contains(query.toUpperCase()),
          )
          .toList();
      context.read<TransactionProvider>().notifyListeners();
    }
  }
}
