import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/widgets/app_drawer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCategories extends StatefulWidget {
  const ExpenseCategories({super.key});

  @override
  State<ExpenseCategories> createState() => _ExpenseCategoriesState();
}

class _ExpenseCategoriesState extends State<ExpenseCategories> {

  TransactionsBloc get blocTransaction => context.read<TransactionsBloc>();

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
          for (int i = 0; i < blocTransaction.listItems.length; i++)
            ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    blocTransaction.listItems[i].isIncome == true ? Colors.blue : Colors.red,
                child: blocTransaction.listItems[i].isIncome == true
                    ? const Icon(
                        Icons.addchart,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.highlight_remove_sharp,
                        color: Colors.white,
                      ),
              ),
              title: Text(blocTransaction.listItems[i].transactionType),
            ),
        ],
      ),
    );
  }
}
