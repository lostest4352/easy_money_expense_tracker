import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_expense_tracker/widgets/app_drawer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
              return Dialog(
                child: SizedBox(
                  height: 400,
                  child: Column(
                    children: [
                      const Spacer(),
                      TextField(
                        controller: categoryController,
                        decoration: const InputDecoration(
                          hintText: "Enter Category",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButton(
                        value: false,
                        items: const [
                          DropdownMenuItem(value: true, child: Text("True")),
                          DropdownMenuItem(value: false, child: Text("False")),
                        ],
                        onChanged: (value) {
                          value = value;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("Save"),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
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
              for (int i = 0; i < blocCategories.listItems.length; i++)
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        blocCategories.listItems[i].isIncome == true
                            ? Colors.blue
                            : Colors.red,
                    child: blocCategories.listItems[i].isIncome == true
                        ? const Icon(
                            Icons.addchart,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.highlight_remove_sharp,
                            color: Colors.white,
                          ),
                  ),
                  title: Text(blocCategories.listItems[i].transactionType),
                ),
            ],
          );
        },
      ),
    );
  }
}
