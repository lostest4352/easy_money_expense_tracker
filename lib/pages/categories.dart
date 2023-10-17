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
          // TODO add below code for moving transactions to these two types if cateory deleted
          // blocCategories.listItems.where((itemsInList) {
          //   return itemsInList.transactionType == "otherIncome" ||
          //       itemsInList.transactionType == "otherExpense";
          // });
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: blocCategories.listItems.length,
                  itemBuilder: (context, index) {
                    final listItems = blocCategories.listItems;
                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CategoryAddOrEditDialog(
                              editMode: true,
                              selectedListItem: listItems[index],
                            );
                          },
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: listItems[index].isIncome == true
                              ? Colors.blue
                              : Colors.red,
                          child: listItems[index].isIncome == true
                              ? const Icon(
                                  Icons.addchart,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.highlight_remove_sharp,
                                  color: Colors.white,
                                ),
                        ),
                        title: Text(listItems[index].transactionType),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
