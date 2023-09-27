import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/global_vars/global_expense.dart';
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 29, 89, 192),
        onPressed: () {},
        child: const Icon(Icons.add),
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
                    listItems[i].isIncome == true ? Colors.blue : Colors.red,
                child: listItems[i].isIncome == true
                    ? const Icon(
                        Icons.addchart,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.highlight_remove_sharp,
                        color: Colors.white,
                      ),
              ),
              title: Text(listItems[i].transactionType),
            ),
        ],
      ),
    );
  }
}
