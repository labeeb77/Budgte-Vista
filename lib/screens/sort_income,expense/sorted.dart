import 'package:flutter/cupertino.dart';

import '../../database/transaction/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';


ValueNotifier incomeTotal = ValueNotifier(0.0);
ValueNotifier expenseTotal = ValueNotifier(0.0);
ValueNotifier balanceTotal = ValueNotifier(0.0);

incomeExpense() {
  incomeTotal.value = 0;
  expenseTotal.value = 0;
  balanceTotal.value = 0;
  final List<TransactionModel> value =
      TransactionsDB.instance.transactionListNotfier.value;

  for (int i = 0; i < value.length; i++) {
    if (CategoryType.income == value[i].category.type) {
      incomeTotal.value = incomeTotal.value + value[i].amount;
    } else {
      expenseTotal.value = expenseTotal.value + value[i].amount;
    }
    balanceTotal.value = incomeTotal.value - expenseTotal.value;
  }
}
