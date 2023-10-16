import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_expense_tracker/widgets/app_drawer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/widgets/category_edit_dialog.dart';

class ExpenseCategories extends StatefulWidget {
  const ExpenseCategories({super.key});

  @override
  State<ExpenseCategories> createState() => _ExpenseCategoriesState();
}

class _ExpenseCategoriesState extends State<ExpenseCategories> {
  final categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 29, 89, 192),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const CategoryAddOrEditDialog(
                editMode: false,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          final blocCategories = context.read<CategoryBloc>();
          return ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              for (final listItem in blocCategories.listItems)
                InkWell(
                  onTap: () {
                    listItem;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CategoryAddOrEditDialog(
                          // categoryController: categoryController,
                          editMode: true,
                          selectedListItem: listItem,
                        );
                      },
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          listItem.isIncome == true ? Colors.blue : Colors.red,
                      child: listItem.isIncome == true
                          ? const Icon(
                              Icons.addchart,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.highlight_remove_sharp,
                              color: Colors.white,
                            ),
                    ),
                    title: Text(listItem.transactionType),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
