import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../database/category/category_db.dart';
import '../../models/category/category_model.dart';
import '../home/widgets/colors.dart';
import 'delete_alert_cat.dart';

class IncomeCategory extends StatelessWidget {
  const IncomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().incomeCategoryListListener,
      builder: (BuildContext context, List<CategoryModel> newList, Widget? _) {
        return newList.isEmpty
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
                      final category = newList[index];
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
                    itemCount: newList.length),
              );
      },
    );
  }
}
