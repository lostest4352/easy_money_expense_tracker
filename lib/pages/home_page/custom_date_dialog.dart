import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/pages/widgets/popup_category_items.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_expense_tracker/pages/page_functions/date_formatter.dart';

class CustomDateDialog extends StatefulWidget {
  const CustomDateDialog({super.key});

  @override
  State<CustomDateDialog> createState() => _CustomDateDialogState();
}

class _CustomDateDialogState extends State<CustomDateDialog> {
  DateTime? selectedDateForStart;
  DateTime? selectedDateForEnd;

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
                  // start date
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TableCalendar(
                                  firstDay: DateTime.utc(2010, 01, 01),
                                  lastDay: selectedDateForEnd ?? DateTime.now(),
                                  availableCalendarFormats: const {
                                    CalendarFormat.month: 'Month',
                                  },
                                  focusedDay:
                                      selectedDateForStart ?? DateTime.now(),
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      selectedDateForStart = selectedDay;
                                    });
                                    context.pop();
                                  },
                                  selectedDayPredicate: (day) {
                                    return isSameDay(selectedDateForStart, day);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: PopupCategoryItems(
                      title: () {
                        if (selectedDateForStart == null) {
                          return "Start Date     ";
                        } else {
                          return "${selectedDateForStart?.formatDayShort()}   ";
                        }
                      }(),
                    ),
                  ),
                  const Text(" - "),
                  // For end date
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TableCalendar(
                                  firstDay: selectedDateForStart ??
                                      DateTime.utc(2010, 01, 01),
                                  lastDay: DateTime.now(),
                                  availableCalendarFormats: const {
                                    CalendarFormat.month: 'Month',
                                  },
                                  focusedDay:
                                      selectedDateForEnd ?? DateTime.now(),
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      selectedDateForEnd = selectedDay;
                                    });
                                    context.pop();
                                  },
                                  selectedDayPredicate: (day) {
                                    return isSameDay(selectedDateForEnd, day);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: PopupCategoryItems(
                      title: () {
                        if (selectedDateForEnd == null) {
                          return "End Date     ";
                        } else {
                          return "${selectedDateForEnd?.formatDayShort()}   ";
                        }
                      }(),
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
