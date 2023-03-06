import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_money1/database/category/category_provider.dart';
import 'package:provider/provider.dart';

import '../home/widgets/colors.dart';
import 'delete_alert_cat.dart';

class IncomeCategory extends StatelessWidget {
  const IncomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, value, child) {
        return value.incomeCategoryProvider.isEmpty
        ? Center(
            child: Text('No income category.',
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
                  final category = value.incomeCategoryProvider[index];
                  return Card(
                    elevation: 10,
                    color: ThemeColor.themeColors,
                    child: Center(
                      child: ListTile(
                        title: Text(
                          category.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
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
                itemCount: value.incomeCategoryProvider.length),
          );
      
    },);
  }
}
