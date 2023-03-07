import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_money1/screens/transactoins/filters/overview_filter.dart';


import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../../screens/sort_income,expense/sorted.dart';

const transactionDbName = 'transactions-database';

// abstract class TransactionDbFunctions {
//   Future<void> addToTransaction(TransactionModel object);
//   Future<List<TransactionModel>> getAllTransactions();
//   Future<void> deleteTransaction(int id);
//   Future<void> updateTransaction(int index, TransactionModel model);
// }

class TransactionProvider extends ChangeNotifier {
  // TransactionsDB._internal();

  // static TransactionsDB instance = TransactionsDB._internal();
  // factory TransactionsDB() {
  //   return instance;
  // }

  List<TransactionModel>transactionList = [];
  List<TransactionModel>overViewNotifier = [];
  List<TransactionModel>overViewGraphtransaction = [];
  String categoryNotifier = ('All');
  String dateNotifier = ('All');

  
  String? categoryId;
   DateTime selectedDate = DateTime.now();
   CategoryModel? selectedCategoryModel;
   CategoryType? selectedCategoryType;
   int value = 0;

   incomeChoiceChip(){
    value = 0;
    selectedCategoryType = CategoryType.income;
    categoryId = null;
    notifyListeners();
   }

   expenseChoiceChip(){
    value = 1;
    selectedCategoryType = CategoryType.expense;
    categoryId = null;
    notifyListeners();
   }

   dateSelect(DateTime? selectedDateTemp){
    if(selectedDateTemp == null){
      selectedDate = DateTime.now();
      notifyListeners();
    }else{
      selectedDate = selectedDateTemp;
      notifyListeners();
    
    }
    notifyListeners();
   }

   set setOverviewTransaction(List<TransactionModel>overViewList){
    overViewNotifier = overViewList;
    notifyListeners();
   }

   set setOverviewGraph(List<TransactionModel> overViewGraphNewList){
    overViewGraphtransaction = overViewGraphNewList;
    notifyListeners();
   }

   set setDateFilter(String dateFilterNewList){
    dateNotifier = dateFilterNewList;
    notifyListeners();
   }
    set setShowCategory(String overShowcategory){
      categoryNotifier = overShowcategory;
      notifyListeners();
    }

    set setTransactionListNotifire(List<TransactionModel> transactonNewList){
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
}
