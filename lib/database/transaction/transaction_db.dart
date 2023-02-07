import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';


import '../../models/transaction/transaction_model.dart';
import '../../screens/sort_income,expense/sorted.dart';

const transactionDbName = 'transactions-database';

abstract class TransactionDbFunctions {
  Future<void> addToTransaction(TransactionModel object);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(int id);
  Future<void> updateTransaction(int index, TransactionModel model);
}

class TransactionsDB implements TransactionDbFunctions {
  TransactionsDB._internal();

  static TransactionsDB instance = TransactionsDB._internal();
  factory TransactionsDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotfier =
      ValueNotifier([]);

  @override
  Future<void> addToTransaction(TransactionModel object) async {
    log('add transaction');
    final dbTrans = await Hive.openBox<TransactionModel>(transactionDbName);
    await dbTrans.put(object.id, object);
    refresh();
  }

  Future<void> refresh() async {
    final list = await getAllTransactions();
    list.sort(
      (a, b) => b.date.compareTo(a.date),
    );
    transactionListNotfier.value.clear();
    transactionListNotfier.value.addAll(list);

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    transactionListNotfier.notifyListeners();
    incomeExpense();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final dbTrans = await Hive.openBox<TransactionModel>(transactionDbName);
    return dbTrans.values.toList();
  }

  @override
  Future<void> deleteTransaction(int id) async {
    final dbTrans = await Hive.openBox<TransactionModel>(transactionDbName);
    await dbTrans.deleteAt(id);
    refresh();
  }

  @override
  Future<void> updateTransaction(int index, TransactionModel model) async {
    final dbTrans = await Hive.openBox<TransactionModel>(transactionDbName);
    await dbTrans.putAt(index, model);
    refresh();
  }
}
