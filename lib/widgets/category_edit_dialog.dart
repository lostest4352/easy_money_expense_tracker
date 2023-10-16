import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_expense_tracker/widgets/popup_textfield_items.dart';
import 'package:go_router/go_router.dart';

class CategoryAddOrEditDialog extends StatefulWidget {
  final TextEditingController categoryController;
  const CategoryAddOrEditDialog({
    Key? key,
    required this.categoryController,
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
                      value: colorsValue,
                      items: [
                        DropdownMenuItem(
                            value: Colors.red.value, child: const Text("Red")),
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
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  final blocCategories = context.read<CategoryBloc>();
                  return ElevatedButton(
                    onPressed: () {
                      if (widget.categoryController.text != "") {
                        blocCategories.addCategory(
                          widget.categoryController.text,
                          isIncome,
                          colorsValue ?? Colors.red.value,
                        );
                        context.pop();
                      }
                    },
                    child: const Text("Save"),
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
