// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/widgets/app_drawer.dart';

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
        label: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(Icons.add),
            ),
            Text("Add ")
          ],
        ),
        backgroundColor: Colors.blueAccent,
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            title: Text("Income"),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
            title: Text("Expenses"),
          ),
        ],
      ),
    );
  }
}
