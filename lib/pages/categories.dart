// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/widgets/app_drawer.dart';

final listItems = [
  {"type": "Clothing", "income": false},
  {"type": "Entertainment", "income": false},
  {"type": "Health", "income": false},
  {"type": "Fuel", "income": false},
  {"type": "Food", "income": false},
  {"type": "Salary", "income": true},
  {"type": "Bonus", "income": true},
  {"type": "Wages", "income": true},
];

class ExpenseCategories extends StatelessWidget {
  const ExpenseCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding: EdgeInsets.all(12),
        label: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(Icons.add),
            ),
            Text("Add category")
          ],
        ),
        backgroundColor: Color.fromARGB(255, 29, 89, 192),
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          for (int i = 0; i < listItems.length; i++)
            ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    listItems[i]["income"] == true ? Colors.blue : Colors.red,
                child: listItems[i]["income"] == true
                    ? Icon(
                        Icons.add,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
              ),
              title: Text("${listItems[i]["type"]}"),
            ),
        ],
      ),
    );
  }
}
