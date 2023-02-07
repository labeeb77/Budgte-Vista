import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';


import '../../models/category/category_model.dart';

const categoryDbName = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(int categoryId);
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB.internal();

  static CategoryDB instance = CategoryDB.internal();

  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListener =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener =
      ValueNotifier([]);
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryDB.add(value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDBS = await Hive.openBox<CategoryModel>(categoryDbName);
    return categoryDBS.values.toList();
  }

  Future<void> refreshUI() async {
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
    final allCategories = await getCategories();

    await Future.forEach(allCategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryListListener.value.add(category);
      } else {
        expenseCategoryListListener.value.add(category);
      }
    });

    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    incomeCategoryListListener.notifyListeners();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    expenseCategoryListListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(int categoryId) async {
    final categoryDBS = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryDBS.deleteAt( categoryId);
    refreshUI();
  }
}
