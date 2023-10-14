import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    bool isTrue = true;
    int? colorsValue;
    return Dialog(
      child: SizedBox(
        height: 400,
        child: StatefulBuilder(builder: (context, newState) {
          return Column(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: widget.categoryController,
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
              TextButton(
                onPressed: () {},
                child: const Text("Save"),
              ),
              const Spacer(),
            ],
          );
        }),
      ),
    );
  }
}
