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

  bool isTrue = true;

  int? colorsValue;

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
              return StatefulBuilder(builder: (context, newState) {
                return Dialog(
                  child: SizedBox(
                    height: 400,
                    child: Column(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: categoryController,
                            decoration: const InputDecoration(
                              hintText: "Enter Category Name",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Transaction Type"),
                              const Spacer(),
                              DropdownButton(
                                value: isTrue,
                                items: const [
                                  DropdownMenuItem(
                                    value: true,
                                    child: Text("Income"),
                                  ),
                                  DropdownMenuItem(
                                    value: false,
                                    child: Text("Expense"),
                                  ),
                                ],
                                onChanged: (value) {
                                  newState(() {
                                    isTrue = value ?? true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Select Color"),
                              const Spacer(),
                              DropdownButton(
                                value: colorsValue,
                                items: [
                                  DropdownMenuItem(
                                      value: Colors.red.value,
                                      child: const Text("Red")),
                                  DropdownMenuItem(
                                      value: Colors.green.value,
                                      child: const Text("Green")),
                                  DropdownMenuItem(
                                      value: Colors.blue.value,
                                      child: const Text("Blue")),
                                  DropdownMenuItem(
                                      value: Colors.yellow.value,
                                      child: const Text("Yellow")),
                                  DropdownMenuItem(
                                      value: Colors.purple.value,
                                      child: const Text("Purple")),
                                  DropdownMenuItem(
                                      value: Colors.brown.value,
                                      child: const Text("Brown")),
                                  DropdownMenuItem(
                                      value: Colors.pink.value,
                                      child: const Text("Pink")),
                                  DropdownMenuItem(
                                      value: Colors.orange.value,
                                      child: const Text("Orange")),
                                ],
                                onChanged: (value) {
                                  newState(() {
                                    colorsValue = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Save"),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                );
              });
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
