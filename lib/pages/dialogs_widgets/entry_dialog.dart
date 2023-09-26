import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/widgets/home_page_popup_items.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class EntryDialog extends StatefulWidget {
  const EntryDialog({
    super.key,
  });

  @override
  State<EntryDialog> createState() => _EntryDialogState();
}

class _EntryDialogState extends State<EntryDialog> {
  DateTime selectedDate = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd');
  String get formattedDate => formatter.format(selectedDate);

  // DateFormat('yyyy-MM-dd').format(DateTime.now())
  Dialog setDateTimeDialog(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            onDaySelected: (selectedDay, focusedDay) {
              debugPrint(formattedDate.toString());
              setState(() {
                selectedDate = selectedDay;
              });
              context.pop();
            },
          ),
        ],
      ),
    );
  }

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
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return setDateTimeDialog(context);
                  },
                );
              },
              child: PopupCategoryItems(
                title: (formattedDate ==
                        DateFormat('yyyy-MM-dd').format(DateTime.now()))
                    ? "Today"
                    : formattedDate.toString(),
              ),
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
                        fontWeight: FontWeight.bold,
                      ),
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
                      color: Colors.blue.shade400,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            const PopupTextFieldTitle(
              title: "Category",
            ),
            const PopupCategoryItems(
              title: "Select Category",
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
