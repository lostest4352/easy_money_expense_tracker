import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/models/dropdown_colors.dart';

import 'package:flutter_expense_tracker/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_expense_tracker/models/category_model.dart';
import 'package:flutter_expense_tracker/widgets/popup_textfield_items.dart';
import 'package:go_router/go_router.dart';

class CategoryAddOrEditDialog extends StatefulWidget {
  final bool editMode;
  final CategoryModel? selectedListItem;
  const CategoryAddOrEditDialog({
    Key? key,
    required this.editMode,
    this.selectedListItem,
  }) : super(key: key);

  @override
  State<CategoryAddOrEditDialog> createState() =>
      _CategoryAddOrEditDialogState();
}

class _CategoryAddOrEditDialogState extends State<CategoryAddOrEditDialog> {
  late bool isIncome;
  late int colorsValue;
  final TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    categoryController.text = widget.selectedListItem?.transactionType ?? "";
    isIncome = widget.selectedListItem?.isIncome ?? true;
    colorsValue = widget.selectedListItem?.colorsValue ?? Colors.red.value;
    super.initState();
  }

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        child: StatefulBuilder(builder: (context, newState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupTextFieldItems(
                  textEditingController: categoryController,
                  hintText: "Enter Category Name",
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
                      value: isIncome,
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
                          isIncome = value ?? true;
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
                        for (final dropdownColors in dropdownColorsList)
                          DropdownMenuItem(
                            value: dropdownColors.colorsValue,
                            child: Text(dropdownColors.colorsName),
                          ),
                      ],
                      onChanged: (value) {
                        newState(() {
                          colorsValue = value ?? Colors.red.value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocConsumer<CategoryBloc, CategoryState>(
                listener: (context, state) {
                  const snackBar = SnackBar(
                    duration: Duration(milliseconds: 1200),
                    backgroundColor:  Colors.white,
                    content: Text(
                      'Only unused cateories can be modified',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                  if (state is DisallowModificationState) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                builder: (context, state) {
                  final blocCategories = context.read<CategoryBloc>();
                  final blocTransactions = context.read<TransactionsBloc>();
                  return Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: [
                        () {
                          if (widget.editMode == true) {
                            return ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actions: [
                                        const Wrap(
                                          children: [
                                            Text(
                                                "Are you sure that you want to delete this category?"),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                blocCategories.add(
                                                  DeleteCategoryEvent(
                                                    context: context,
                                                    selectedListItem: widget
                                                        .selectedListItem!,
                                                    transactionList:
                                                        blocTransactions
                                                            .transactionList,
                                                  ),
                                                );
                                                context.pop();
                                              },
                                              child: const Text(
                                                "Ok",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context.pop();
                                              },
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text("Delete"),
                            );
                          } else {
                            return const SizedBox();
                          }
                        }(),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            if (categoryController.text != "") {
                              blocCategories.add(
                                AddOrEditCategoryEvent(
                                  context: context,
                                  editMode: widget.editMode,
                                  transactionType: categoryController.text,
                                  isIncome: isIncome,
                                  colorsValue: colorsValue,
                                  transactionList:
                                      blocTransactions.transactionList,
                                  selectedListItem: widget.selectedListItem,
                                ),
                              );
                            }
                          },
                          child: const Text("Save"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        }),
      ),
    );
  }
}
