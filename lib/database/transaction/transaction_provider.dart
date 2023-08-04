import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';


const transactionDbName = 'transactions-database';

class TransactionProvider extends ChangeNotifier {
  List<TransactionModel> transactionList = [];
  List<TransactionModel> overViewNotifier = [];
  List<TransactionModel> overViewGraphtransaction = [];
  double incomeTotal = 0;
  double expenseTotal = 0;
  double balanceTotal = 0;
  String categoryNotifier = ('All');
  String dateNotifier = ('All');

  String? categoryId;
  DateTime selectedDate = DateTime.now();
  CategoryModel? selectedCategoryModel;
  CategoryType? selectedCategoryType;
  int value = 0;

  incomeChoiceChip() {
    value = 0;
    selectedCategoryType = CategoryType.income;
    categoryId = null;
    notifyListeners();
  }

  expenseChoiceChip() {
    value = 1;
    selectedCategoryType = CategoryType.expense;
    categoryId = null;
    notifyListeners();
  }

  dateSelect(DateTime? selectedDateTemp) {
    if (selectedDateTemp == null) {
      selectedDate = DateTime.now();
      notifyListeners();
    } else {
      selectedDate = selectedDateTemp;
      notifyListeners();
    }
    notifyListeners();
  }

  set setOverviewTransaction(List<TransactionModel> overViewList) {
    overViewNotifier = overViewList;
    notifyListeners();
  }

  set setOverviewGraph(List<TransactionModel> overViewGraphNewList) {
    overViewGraphtransaction = overViewGraphNewList;
    notifyListeners();
  }

  set setDateFilter(String dateFilterNewList) {
    dateNotifier = dateFilterNewList;
    notifyListeners();
  }

  set setShowCategory(String overShowcategory) {
    categoryNotifier = overShowcategory;
    notifyListeners();
  }

  set setTransactionListNotifire(List<TransactionModel> transactonNewList) {
    transactionList = transactonNewList;
    notifyListeners();
  }

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
    transactionList.clear();
    transactionList.addAll(list);

    incomeExpense();
    notifyListeners();
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final dbTrans = await Hive.openBox<TransactionModel>(transactionDbName);
    return dbTrans.values.toList();
  }

  Future<void> deleteTransaction(int id) async {
    final dbTrans = await Hive.openBox<TransactionModel>(transactionDbName);
    await dbTrans.deleteAt(id);
    refresh();
  }

  Future<void> updateTransaction(int index, TransactionModel model) async {
    final dbTrans = await Hive.openBox<TransactionModel>(transactionDbName);
    await dbTrans.putAt(index, model);
    refresh();
  }
  incomeExpense() {
  incomeTotal = 0;
  expenseTotal = 0;
  balanceTotal = 0;
  final List<TransactionModel> value = transactionList;
      

  for (int i = 0; i < value.length; i++) {
    if (CategoryType.income == value[i].category.type) {
      incomeTotal = incomeTotal + value[i].amount;
    } else {
      expenseTotal = expenseTotal + value[i].amount;
    }
    balanceTotal = incomeTotal - expenseTotal;
    notifyListeners();
  }
}
}
