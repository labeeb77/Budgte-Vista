import 'package:flutter/material.dart';

class IncomeWidget extends StatelessWidget {
  IncomeWidget({super.key});

  final datecontroller = TextEditingController();
  final categorycontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  final commentcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, right: 10, left: 10),
      child: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: datecontroller,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.date_range_outlined),
                border: OutlineInputBorder(),
                hintText: 'Select Date',
              ),
            ),
          ),
          ListTile(
            title: TextField(
              controller: categorycontroller,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.category_outlined),
                border: OutlineInputBorder(),
                hintText: 'Select category',
              ),
            ),
          ),
          ListTile(
            title: TextField(
              controller: amountcontroller,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.currency_rupee_rounded),
                border: OutlineInputBorder(),
                hintText: 'Enter Amount',
              ),
            ),
          ),
          ListTile(
            title: TextField(
              controller: commentcontroller,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.description_outlined),
                border: OutlineInputBorder(),
                hintText: 'Note',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 35, right: 20, left: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 21, 141, 131),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
