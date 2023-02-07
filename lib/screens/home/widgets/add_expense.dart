import 'package:flutter/material.dart';

class ExpenseWidget extends StatelessWidget {
  const ExpenseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 25),
      child: ListView(
        children: [
          const ListTile(
            title: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.date_range_outlined),
                border: OutlineInputBorder(),
                hintText: 'Select Date',
              ),
            ),
          ),
          const ListTile(
            title: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.category_outlined),
                border: OutlineInputBorder(),
                hintText: 'Select category',
              ),
            ),
          ),
          const ListTile(
            title: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.currency_rupee_rounded),
                border: OutlineInputBorder(),
                hintText: 'Enter Amount',
              ),
            ),
          ),
          const ListTile(
            title: TextField(
              decoration: InputDecoration(
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
