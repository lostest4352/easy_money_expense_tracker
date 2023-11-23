import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/pages/widgets/popup_category_items.dart';

class CustomDateDialog extends StatefulWidget {
  const CustomDateDialog({super.key});

  @override
  State<CustomDateDialog> createState() => _CustomDateDialogState();
}

class _CustomDateDialogState extends State<CustomDateDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 200,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Set Custom Time Period",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const PopupCategoryItems(
                      title: "Start Date     ",
                    ),
                  ),
                  const Text(" - "),
                  InkWell(
                    onTap: () {},
                    child: const PopupCategoryItems(
                      title: "End Date       ",
                    ),
                  ),
                ],
              ),
            ),
            // Cancel and Save
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
