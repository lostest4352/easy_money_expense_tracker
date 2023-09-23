import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/widgets/popup_textfield_items.dart';
import 'package:flutter_expense_tracker/widgets/popup_textfield_title.dart';
import 'package:go_router/go_router.dart';

class EntryDialog extends StatelessWidget {
  const EntryDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      backgroundColor: Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 15,
            ),
            const PopupTextFieldTitle(
              title: "Date",
            ),
            const PopupTextFieldItems(
              hintText: "Today",
            ),
            const SizedBox(
              height: 5,
            ),
            const PopupTextFieldTitle(
              title: "Amount",
            ),
            const PopupTextFieldItems(
              hintText: "Enter Amount",
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.red.shade400,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.blue.shade400, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(),
            const PopupTextFieldTitle(
              title: "Category",
            ),
            const PopupTextFieldItems(
              hintText: "Select Category",
            ),
            const SizedBox(
              height: 5,
            ),
            const PopupTextFieldTitle(
              title: "Note",
            ),
            const PopupTextFieldItems(
              hintText: "Note(Optional)",
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
