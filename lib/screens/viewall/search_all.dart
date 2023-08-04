import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_money1/database/transaction/transaction_provider.dart';
import 'package:provider/provider.dart';

class SearchAll extends StatelessWidget {
   SearchAll({Key? key}) : super(key: key);
   final TextEditingController _searchQueryController = TextEditingController();

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
            controller: _searchQueryController,
            onChanged: (value) {
              
              displayResults(value, context);
              log(value);
            },
            decoration:  InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Search',
              suffixIcon: IconButton(onPressed: (){
                _searchQueryController.clear();
                context.read<TransactionProvider>().overViewNotifier = context.read<TransactionProvider>().transactionList;
                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                context.read<TransactionProvider>().notifyListeners();
              },
               icon: const Icon(Icons.close,color: Colors.black,)),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
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
      context.read<TransactionProvider>().overViewGraphtransaction =
          context.read<TransactionProvider>().transactionList;
    } else {
      context.read<TransactionProvider>().overViewNotifier = context
          .read<TransactionProvider>()
          .transactionList
          .where(
            (element) =>
                element.category.name
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                element.notes.toLowerCase().contains(query.toLowerCase()),
              
          )
          .toList();
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          context.read<TransactionProvider>().notifyListeners();
    }
  }
}
