import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';


import '../../models/category/category_model.dart';

const categoryDbName = 'category-database';

//  class CategoryProvider extends ChangeNotifier {


//   Future<List<CategoryModel>> getCategories();
//   Future<void> insertCategory(CategoryModel value);
//   Future<void> deleteCategory(int categoryId);
// }

class CategoryProvider extends ChangeNotifier {
  // CategoryDB.internal();

  // static CategoryDB instance = CategoryDB.internal();

  // factory CategoryDB() {
  //   return instance;
  // }

List<CategoryModel> incomeCategoryProvider = [];
List<CategoryModel> expenseCategoryProvider = [];
  

 
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryDB.add(value);
    refreshUI();
  }

  
  Future<List<CategoryModel>> getCategories() async {
    final categoryDBS = await Hive.openBox<CategoryModel>(categoryDbName);
    return categoryDBS.values.toList();
  }

  Future<void> refreshUI() async {

    final allCategories = await getCategories();
    incomeCategoryProvider.clear();
    expenseCategoryProvider.clear();
    await Future.forEach(allCategories
    , (CategoryModel category) {
      if( category.type ==CategoryType.income){
        incomeCategoryProvider.add(category);
      }else{
        expenseCategoryProvider.add(category);
      }
    });
    notifyListeners();
  }

  Future<void> deleteCategory(int categoryId) async {
    final categoryDBS = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryDBS.deleteAt( categoryId);
    refreshUI();
  }
}
