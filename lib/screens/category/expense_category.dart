import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../../database/category/category_provider.dart';
import '../home/widgets/colors.dart';
import 'delete_alert_cat.dart';

class ExpenseCategory extends StatelessWidget {
  const ExpenseCategory({super.key});

  @override
  Widget build(BuildContext context) {
   return Consumer<CategoryProvider>(builder: (context, value, child) {
      return value.expenseCategoryProvider.isEmpty
        ? Center(
            child: Text('No expense category',
                style:
                    GoogleFonts.quicksand(color: ThemeColor.themeColors)),
          )
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 2),
                itemBuilder: (context, index) {
                  final category = value.expenseCategoryProvider[index];
                  return Card(
                    elevation: 10,
                    color: ThemeColor.themeColors,
                    child: Center(
                      child: ListTile(
                        title: Text(
                          category.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            alertDeleteCategory(context, index);
                          },
                          icon: const Icon(
                            Icons.delete_sweep,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: value.expenseCategoryProvider.length),
          );
   },);
  }
}
