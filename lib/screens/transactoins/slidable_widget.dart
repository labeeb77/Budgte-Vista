import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:my_money1/screens/transactoins/update_transaction.dart';


import '../../database/transaction/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';

class SlidableWidget extends StatelessWidget {
  const SlidableWidget({
    super.key,
    required this.trValue,
    required this.index,
  });

  final TransactionModel trValue;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return UpdateTransaction(
                    id: index,
                    object: trValue,
                  );
                },
              ),
            );
          },
          backgroundColor: const Color.fromARGB(255, 0, 150, 92),
          icon: Icons.edit,

          //borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        SlidableAction(
          onPressed: (context) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Do you want to delete this transaction ?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        
                        Navigator.of(context).pop();
                        AnimatedSnackBar.rectangle(
                                'Success', 'Transaction deleted successfully..',
                                type: AnimatedSnackBarType.success,
                                brightness: Brightness.light,
                                duration: const Duration(seconds: 5))
                            .show(
                          context,
                        );
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No'),
                    )
                  ],
                );
              },
            );
          },
          backgroundColor: const Color.fromARGB(255, 187, 13, 13),
          icon: Icons.delete,
        ),
      ]),
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          leading: trValue.type == CategoryType.income
              ? const Icon(
                  Icons.arrow_circle_up_outlined,
                  color: Color.fromARGB(255, 42, 131, 45),
                  size: 38,
                )
              : const Icon(
                  Icons.arrow_circle_down_outlined,
                  color: Color.fromARGB(255, 194, 42, 31),
                  size: 38,
                ),
          title: Text(trValue.category.name),
          subtitle: Text(
            parseDate(trValue.date),
          ),
          trailing: Text(' ₹ ${trValue.amount}'),
        ),
      ),
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.yMMMEd().format(date);
  }
}
