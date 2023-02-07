import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';


import '../../database/category/category_db.dart';

alertDeleteCategory(BuildContext context, int id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Do you want to delete this transaction ?'),
        actions: [
          TextButton(
              onPressed: () {
                CategoryDB.instance.deleteCategory(id);
                CategoryDB.instance.incomeCategoryListListener;
                CategoryDB.instance.expenseCategoryListListener;
                Navigator.of(context).pop();
                AnimatedSnackBar.rectangle(
                        'Success', 'Category deleted successfully..',
                        type: AnimatedSnackBarType.success,
                        brightness: Brightness.light,
                        duration: const Duration(seconds: 5))
                    .show(
                  context,
                );
              },
              child: const Text('Yes')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'))
        ],
      );
    },
  );
}
