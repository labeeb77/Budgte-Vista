import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../database/category/category_db.dart';
import '../../models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);
ValueNotifier<CategoryType> selectedCategoryType =
    ValueNotifier(CategoryType.income);
final formKey = GlobalKey<FormState>();

Future<void> categoryAddPopup(
    BuildContext context, checkBool, CategoryType boolValue) async {
  final addCatcontroller = TextEditingController();
  showDialog(
    context: context,
    builder: ((ctx) {
      return SimpleDialog(
        title: Text('Add Category',
            style: GoogleFonts.quicksand(fontWeight: FontWeight.w600)),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: ValueListenableBuilder(
                valueListenable: selectedCategoryNotifier,
                builder: (context, selected, _) {
                  return TextFormField(
                    validator: (value) => value == null || value.isEmpty
                        ? "Please Enter Your Category"
                        : null,
                    controller: addCatcontroller,
                    decoration: InputDecoration(
                        hintText: boolValue == CategoryType.income
                            ? 'Add Income'
                            : 'Add Expense',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0))),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                final add = addCatcontroller.text;
                if (formKey.currentState!.validate()) {
                  // final type = selectedCategoryNotifier;
                  final category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: add,
                      type: boolValue);

                  CategoryDB.instance.insertCategory(category);
                  CategoryDB.instance.refreshUI();
                  Navigator.of(ctx).pop();
                  AnimatedSnackBar.rectangle(
                          'Success', 'Category added successfully..',
                          type: AnimatedSnackBarType.success,
                          brightness: Brightness.light,
                          duration: const Duration(seconds: 5))
                      .show(
                    context,
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 196, 41, 3),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              child: const Text('Add'),
            ),
          )
        ],
      );
    }),
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext context, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: newCategory,
              onChanged: ((value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;
                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                selectedCategoryNotifier.notifyListeners();
              }),
            );
          },
        ),
        Text(title)
      ],
    );
  }
}
