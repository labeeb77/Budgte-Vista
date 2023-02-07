import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../database/category/category_db.dart';
import '../../database/transaction/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../category/category_popup.dart';
import '../home/widgets/colors.dart';

class AddTransactions extends StatefulWidget {
  const AddTransactions({super.key});

  static const routeName = 'add-transaction';

  @override
  State<AddTransactions> createState() => _AddTransactionsState();
}

class _AddTransactionsState extends State<AddTransactions> {
  final _formKey = GlobalKey<FormState>();
  bool _isVisibleDate = false;

  DateTime? _selectedDate;

  CategoryModel? selectedCategoryModel;
  String? _categoryId;

  final noteEditingController = TextEditingController();
  final amountEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    TransactionsDB.instance.refresh();
  }

  Future<void> addToTransaction() async {
    final noteText = noteEditingController.text;
    final amountText = amountEditingController.text;
    if (amountText.isEmpty) {
      return;
    }
    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null) {
      return;
    }

    // if (noteText.isEmpty) {
    //   return;
    // }

    if (_selectedDate == null) {
      return;
    }
    if (_categoryId == null) {
      return;
    }

    final models = TransactionModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      category: selectedCategoryModel!,
      amount: parsedAmount,
      notes: noteText,
      date: _selectedDate!,
      type: selectedCategoryType.value,
    );

    TransactionsDB.instance.addToTransaction(models);
    TransactionsDB.instance.refresh();
    Navigator.of(context).pop();
    AnimatedSnackBar.rectangle('Success', 'Transaction Added successfully..',
            type: AnimatedSnackBarType.success,
            brightness: Brightness.light,
            duration: const Duration(seconds: 5))
        .show(
      context,
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.yMMMEd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Transactions',
            style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 255, 255, 255))),
        centerTitle: true,
        backgroundColor: ThemeColor.themeColors,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, right: 30, left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ChoiceChip(
                      elevation: 10,
                      label: const Text(
                        'Income',
                        style: TextStyle(color: Colors.white),
                      ),
                      selected:
                          selectedCategoryType.value == CategoryType.income,
                      selectedColor: const Color.fromARGB(255, 0, 148, 67),
                      disabledColor: const Color.fromARGB(255, 129, 128, 128),
                      onSelected: (bool selected) {
                        setState(
                          () {
                            selectedCategoryType.value = CategoryType.income;
                            _categoryId = null;
                          },
                        );
                      },
                    ),
                    ChoiceChip(
                      elevation: 10,
                      label: const Text('Expense',
                          style: TextStyle(color: Colors.white)),
                      selected:
                          selectedCategoryType.value == CategoryType.expense,
                      selectedColor: const Color.fromARGB(255, 153, 0, 0),
                      disabledColor: const Color.fromARGB(255, 122, 122, 122),
                      onSelected: (bool selected) {
                        setState(
                          () {
                            selectedCategoryType.value = CategoryType.expense;

                            _categoryId = null;
                          },
                        );
                      },
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
                    child: DropdownButtonFormField(
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
                      value: _categoryId,
                      items: (selectedCategoryType.value == CategoryType.income
                              ? CategoryDB.instance.incomeCategoryListListener
                              : CategoryDB.instance.expenseCategoryListListener)
                          .value
                          .map(
                        (e) {
                          return DropdownMenuItem(
                            value: e.id,
                            child: Text(e.name),
                            onTap: () {
                              setState(
                                () {
                                  selectedCategoryModel = e;
                                },
                              );
                            },
                          );
                        },
                      ).toList(),
                      onChanged: ((selectedValue) {
                        setState(
                          () {
                            _categoryId = selectedValue;
                            CategoryDB.instance.refreshUI();
                          },
                        );
                      }),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      log(selectedCategoryType.value.name);
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
                validator: (value) => value == null || value.isEmpty
                    ? " Please enter a amount"
                    : null,
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
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Notes',
                    prefixIcon: const Icon(Icons.note_alt_outlined)),
                maxLines: null,
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton.icon(
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

                  if (selectedDateTemp == null) {
                    setState(
                      () {
                        _selectedDate = DateTime.now();
                      },
                    );
                  } else {
                    setState(
                      () {
                        _selectedDate = selectedDateTemp;
                      },
                    );
                  }
                },
                icon: const Icon(Icons.calendar_month),
                label: Text(_selectedDate == null
                    ? parseDate(DateTime.now())
                    : parseDate(_selectedDate!)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Visibility(
                  visible: _isVisibleDate,
                  child: const Text('Please select date',
                      style: TextStyle(color: Colors.red)),
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
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_selectedDate == null) {
                      setState(
                        () {
                          _selectedDate = DateTime.now();
                        },
                      );
                    } else {
                      setState(
                        () {
                          _isVisibleDate = false;
                        },
                      );
                    }
                    if (_categoryId == null) {
                      setState(
                        () {},
                      );
                    } else {
                      setState(
                        () {},
                      );
                    }

                    if (_formKey.currentState!.validate()) {
                      addToTransaction();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 35, right: 35),
                    child: Text(
                      'Add',
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
}
