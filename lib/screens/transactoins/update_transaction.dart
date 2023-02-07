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

class UpdateTransaction extends StatefulWidget {
  const UpdateTransaction({
    Key? key,
    required this.object,
    required this.id,
  }) : super(key: key);

  final int id;
  final TransactionModel object;

  @override
  State<UpdateTransaction> createState() => _UpdateTransactionState();
}

class _UpdateTransactionState extends State<UpdateTransaction> {
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController noteEditingController = TextEditingController();
  DateTime? _selectedDate;

  CategoryModel? selectedCategoryModel;
  String? _categoryId;

  final __formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _categoryId = widget.object.category.id;
    amountEditingController =
        TextEditingController(text: widget.object.amount.toString());
    noteEditingController = TextEditingController(text: widget.object.notes);

    _selectedDate = widget.object.date;
    selectedCategoryType.value = widget.object.type;
    selectedCategoryModel = widget.object.category;
  }

  @override
  Widget build(BuildContext context) {
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
                    ChoiceChip(
                      elevation: 10,
                      label: const Text(
                        'Income',
                        style: TextStyle(color: Colors.white),
                      ),
                      selected:
                          selectedCategoryType.value == CategoryType.income,
                      // _chipValue == 0,
                      selectedColor: const Color.fromARGB(255, 0, 148, 67),
                      disabledColor: const Color.fromARGB(255, 129, 128, 128),
                      onSelected: (bool selected) {
                        setState(
                          () {
                            //_chipValue = 0;
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
                      //_chipValue == 1,
                      selectedColor: const Color.fromARGB(255, 153, 0, 0),
                      disabledColor: const Color.fromARGB(255, 122, 122, 122),
                      onSelected: (bool selected) {
                        setState(
                          () {
                            // _chipValue = 1;
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
                      onChanged: (selectedValue) {
                        setState(
                          () {
                            _categoryId = selectedValue;
                          },
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
              TextButton.icon(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: ThemeColor.themeColors,
                              )))),
                  onPressed: () async {
                    final selectedDateTemp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now());

                    if (selectedDateTemp == null) {
                      return;
                    } else {
                      setState(() {
                        _selectedDate = selectedDateTemp;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_month),
                  label: Text(_selectedDate == null
                      ? 'Select Date'
                      : parseDate(_selectedDate!))),
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
                    if (_categoryId == null) {
                      setState(() {});
                    } else {
                      setState(() {});
                    }

                    if (__formkey.currentState!.validate()) {
                      updateTransaction();
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

  Future<void> updateTransaction() async {
    final amountText = amountEditingController.text;
    final noteText = noteEditingController.text;
    if (amountText.isEmpty) {
      return;
    }

    // if (noteText.isEmpty) {
    //   return;
    // }

    final parseAmount = double.tryParse(amountText);
    if (parseAmount == null) {
      return;
    }

    if (_categoryId == null) {
      return;
    }

    if (_selectedDate == null) {
      return;
    }

    final models = TransactionModel(
      category: selectedCategoryModel!,
      amount: parseAmount,
      date: _selectedDate!,
      notes: noteText,
      type: selectedCategoryType.value,
      id: widget.object.id,
    );

    TransactionsDB.instance.updateTransaction(widget.id, models);
    Navigator.of(context).pop();
    TransactionsDB.instance.refresh();

    AnimatedSnackBar.rectangle('Success', 'Transaction updated successfully..',
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
}
