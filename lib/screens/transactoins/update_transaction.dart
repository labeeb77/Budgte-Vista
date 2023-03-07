import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_money1/database/transaction/transaction_provider.dart';
import 'package:provider/provider.dart';

import '../../database/category/category_db.dart';
import '../../database/category/category_provider.dart';
import '../../database/transaction/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../category/category_popup.dart';
import '../home/widgets/colors.dart';

class UpdateTransaction extends StatelessWidget {
  UpdateTransaction({
    Key? key,
    required this.object,
    required this.id,
  }) : super(key: key);

  final int id;
  final TransactionModel object;

  TextEditingController amountEditingController = TextEditingController();
  TextEditingController noteEditingController = TextEditingController();

  final __formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Provider.of<TransactionProvider>(context, listen: false).categoryId =
        object.category.id;
    amountEditingController =
        TextEditingController(text: object.amount.toString());
    noteEditingController = TextEditingController(text: object.notes);
    Provider.of<TransactionProvider>(context, listen: false).selectedDate =
        object.date;
    Provider.of<TransactionProvider>(context, listen: false)
        .selectedCategoryType = object.type;
    Provider.of<TransactionProvider>(context, listen: false)
        .selectedCategoryModel = object.category;
    Provider.of<TransactionProvider>(context, listen: false).value =
        object.type.index;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Update',
            style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 255, 255, 255))),
        centerTitle: true,
        backgroundColor: ThemeColor.themeColors,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: __formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, right: 30, left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Consumer<TransactionProvider>(
                      builder: (context, proValue, child) => ChoiceChip(
                        elevation: 10,
                        label: const Text(
                          'Income',
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: proValue.value == 0,
                        selectedColor: const Color.fromARGB(255, 0, 148, 67),
                        disabledColor: const Color.fromARGB(255, 129, 128, 128),
                        onSelected: (bool selected) {
                          proValue.incomeChoiceChip();
                        },
                      ),
                    ),
                    Consumer<TransactionProvider>(
                      builder: (context, porValue, child) => ChoiceChip(
                        elevation: 10,
                        label: const Text('Expense',
                            style: TextStyle(color: Colors.white)),
                        selected: porValue.value == 1,
                        selectedColor: const Color.fromARGB(255, 153, 0, 0),
                        disabledColor: const Color.fromARGB(255, 122, 122, 122),
                        onSelected: (bool selected) {
                          porValue.expenseChoiceChip();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Consumer2<TransactionProvider, CategoryProvider>(
                      builder: (context, valueTr, valueCt, child) {
                        return DropdownButtonFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select category';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.category),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(width: 1))),
                          hint: const Text('Select Category'),
                          value: valueTr.categoryId,
                          items: (valueTr.selectedCategoryType ==
                                      CategoryType.income
                                  ? valueCt.incomeCategoryProvider
                                  : valueCt.expenseCategoryProvider)
                              .map(
                            (e) {
                              return DropdownMenuItem(
                                value: e.id,
                                child: Text(e.name),
                                onTap: () {
                                  context.read<CategoryProvider>().refreshUI();
                                  valueTr.selectedCategoryModel = e;
                                },
                              );
                            },
                          ).toList(),
                          onChanged: ((selectedValue) {
                            valueTr.categoryId = selectedValue;
                          }),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      categoryAddPopup(
                          context, false, selectedCategoryType.value);
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                // validator: (value) => value == null || value.isEmpty
                //     ? " Please enter a amount"
                //     : null,
                controller: amountEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Amount',
                    prefixIcon: const Icon(Icons.monetization_on)),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                // validator: (value) => value == null || value.isEmpty
                //     ? "Please enter your notes "
                //     : null,
                controller: noteEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Notes',
                    prefixIcon: const Icon(Icons.note)),
                maxLines: null,
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<TransactionProvider>(
                builder: (context, value, child) => TextButton.icon(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: ThemeColor.themeColors,
                          )),
                    ),
                  ),
                  onPressed: () async {
                    final selectedDateTemp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now());
                    value.dateSelect(selectedDateTemp);
                  },
                  icon: const Icon(Icons.calendar_month),
                  label: Text(value.selectedDate == null
                      ? parseDate(DateTime.now())
                      : parseDate(
                          context.read<TransactionProvider>().selectedDate)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 170,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        ThemeColor.themeColors,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ))),
                  onPressed: () {
                    if (__formkey.currentState!.validate()) {
                      updateTransaction(context);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 35, right: 35),
                    child: Text(
                      'Update',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//....update function....//

  Future<void> updateTransaction(context) async {
    final amountText = amountEditingController.text;
    final noteText = noteEditingController.text;
    if (amountText.isEmpty) {
      return;
    }

    final parseAmount = double.tryParse(amountText);
    if (parseAmount == null) {
      return;
    }

    if (Provider.of<TransactionProvider>(context, listen: false).categoryId ==
        null) {
      return;
    }

    if (Provider.of<TransactionProvider>(context, listen: false)
            .selectedCategoryType ==
        null) {
      return;
    }

    final models = TransactionModel(
      category: Provider.of<TransactionProvider>(context, listen: false)
          .selectedCategoryModel!,
      amount: parseAmount,
      date:
          Provider.of<TransactionProvider>(context, listen: false).selectedDate,
      notes: noteText,
      type: Provider.of<TransactionProvider>(context, listen: false)
          .selectedCategoryType!,
      id: object.id,
    );

    await Provider.of<TransactionProvider>(context, listen: false)
        .updateTransaction(id, models);

    Navigator.of(context).pop();

    AnimatedSnackBar.rectangle('Success', 'Transaction updated successfully..',
            type: AnimatedSnackBarType.success,
            brightness: Brightness.light,
            duration: const Duration(seconds: 3))
        .show(
      context,
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.yMMMEd().format(date);
  }
}
