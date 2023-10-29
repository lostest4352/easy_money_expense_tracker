import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/pages/widgets/app_drawer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/pages/widgets/category_modify_dialog.dart';

class ExpenseCategories extends StatefulWidget {
  const ExpenseCategories({super.key});

  @override
  State<ExpenseCategories> createState() => _ExpenseCategoriesState();
}

class _ExpenseCategoriesState extends State<ExpenseCategories> {
  final categoryController = TextEditingController();

  CategoryBloc get blocCategories => context.read<CategoryBloc>();

  Stream<List<CategoryModelIsar>> get categoryStream =>
      blocCategories.isarService.listenCategoryData();

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
              return const CategoryModifyDialog(
                editMode: false,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          // TODO add below like code for moving transactions to these two types if cateory deleted
          // blocCategories.listItems.where((itemsInList) {
          //   return itemsInList.transactionType == "otherIncome" ||
          //       itemsInList.transactionType == "otherExpense";
          // });

          return StreamBuilder(
              stream: categoryStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center();
                }
                if (snapshot.data!.isEmpty) {
                  blocCategories.add(AddDefaultItemsEvent());
                }
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CategoryModifyDialog(
                                    editMode: true,
                                    selectedListItem: snapshot.data?[index],
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    snapshot.data?[index].isIncome == true
                                        ? Colors.blue
                                        : Colors.red,
                                child: snapshot.data?[index].isIncome == true
                                    ? const Icon(
                                        Icons.addchart,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.highlight_remove_sharp,
                                        color: Colors.white,
                                      ),
                              ),
                              title: Text(
                                  snapshot.data?[index].transactionType ??
                                      "none"),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
