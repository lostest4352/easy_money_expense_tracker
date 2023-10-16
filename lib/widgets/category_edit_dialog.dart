import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/models/dropdown_colors.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_expense_tracker/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_expense_tracker/models/category_model.dart';
import 'package:flutter_expense_tracker/widgets/popup_textfield_items.dart';

class CategoryAddOrEditDialog extends StatefulWidget {
  final TextEditingController categoryController;
  final bool editMode;
  final CategoryModel? selectedListItem;
  const CategoryAddOrEditDialog({
    Key? key,
    required this.categoryController,
    required this.editMode,
    this.selectedListItem,
  }) : super(key: key);

  @override
  State<CategoryAddOrEditDialog> createState() =>
      _CategoryAddOrEditDialogState();
}

class _CategoryAddOrEditDialogState extends State<CategoryAddOrEditDialog> {
  bool isIncome = true;
  int? colorsValue;

  @override
  Widget build(BuildContext context) {
    if (widget.editMode == true) {
      widget.categoryController.text =
          widget.selectedListItem?.transactionType ?? "";
    }

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
                  textEditingController: widget.categoryController,
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
                      value: (widget.editMode == true)
                          ? widget.selectedListItem?.colorsValue
                          : colorsValue,
                      items: [
                        for (final dropdownColors in dropdownColorsList)
                          DropdownMenuItem(
                            value: dropdownColors.colorsValue,
                            child: Text(dropdownColors.colorsName),
                          ),
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
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  final blocCategories = context.read<CategoryBloc>();
                  return Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: [
                        () {
                          if (widget.editMode == true) {
                            return ElevatedButton(
                              onPressed: () {
                                // blocCategories.
                                debugPrint(widget.selectedListItem?.colorsValue
                                    .toString());
                              },
                              child: const Text("Delete"),
                            );
                          } else {
                            return Container();
                          }
                        }(),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            if (widget.categoryController.text != "") {
                              blocCategories.addCategory(
                                widget.categoryController.text,
                                isIncome,
                                () {
                                  if (widget.editMode == true) {
                                    return widget.selectedListItem!.colorsValue;
                                  } else {
                                    return colorsValue ?? Colors.red.value;
                                  }
                                }(),
                              );
                              context.pop();
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
