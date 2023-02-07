import 'package:flutter/material.dart';

import '../../database/transaction/transaction_db.dart';
import '../transactoins/transaction_list.dart';

class SearchAll extends StatefulWidget {
  const SearchAll({Key? key}) : super(key: key);

  @override
  State<SearchAll> createState() => _SearchAllState();
}

class _SearchAllState extends State<SearchAll> {
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
            onChanged: (value) => displayResults(value),
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

  displayResults(String query) {
    if (query.isEmpty) {
      overViewNotifier.value =
          TransactionsDB.instance.transactionListNotfier.value;
    } else {
      overViewNotifier.value = overViewNotifier.value
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
    }
  }
}
