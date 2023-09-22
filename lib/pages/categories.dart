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
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Income"),
          ),
          ListTile(
            leading: Icon(Icons.remove),
            title: Text("Expenses"),
          ),

        ],
      ),
    );
  }
}
