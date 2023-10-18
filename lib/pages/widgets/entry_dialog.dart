import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:flutter_expense_tracker/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/models/category_model.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:flutter_expense_tracker/pages/widgets/category_edit_dialog.dart';
import 'package:flutter_expense_tracker/pages/widgets/popup_category_items.dart';
import 'package:flutter_expense_tracker/pages/widgets/popup_textfield_items.dart';
import 'package:flutter_expense_tracker/pages/widgets/popup_textfield_title.dart';

class EntryDialog extends StatefulWidget {
  final bool editMode;
  final TransactionModel? transaction;
  const EntryDialog({
    Key? key,
    required this.editMode,
    this.transaction,
  }) : super(key: key);

  @override
  State<EntryDialog> createState() => _EntryDialogState();
}

class _EntryDialogState extends State<EntryDialog> {
  // Text Controllers
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  final categoryController = TextEditingController();

  // Date Related
  DateTime selectedDate = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd');
  // String get formattedDate => formatter.format(selectedDate);
  late String formattedDate;
  // Current date unchanged unlike above
  final currentDateFormatted = DateFormat('yyyy-MM-dd').format(DateTime.now());

  late String? categoryItem;
  CategoryModel? categoryValueFromListItem;

  @override
  void initState() {
    super.initState();
    if (widget.editMode == true) {
      amountController.text = widget.transaction?.amount.toString() ?? "";
      noteController.text = widget.transaction?.note ?? "";
      formattedDate =
          formatter.format(DateTime.parse(widget.transaction!.dateTime));
      categoryItem = widget.transaction?.categoryModel.transactionType;
    } else {
      formattedDate = formatter.format(selectedDate);
      categoryItem = null;
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        final blocTransaction = context.read<TransactionsBloc>();
        final blocCategories = context.read<CategoryBloc>();
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
                    if (widget.editMode == false) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TableCalendar(
                                  firstDay: DateTime.utc(2010, 10, 16),
                                  lastDay: DateTime.now(),
                                  availableCalendarFormats: const {
                                    CalendarFormat.month: 'Month',
                                  },
                                  focusedDay: selectedDate,
                                  onDaySelected: (selectedDay, focusedDay) {
                                    debugPrint(formattedDate.toString());
                                    setState(() {
                                      selectedDate = selectedDay;
                                    });
                                    context.pop();
                                  },
                                  selectedDayPredicate: (day) {
                                    return isSameDay(selectedDate, day);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: PopupCategoryItems(
                    title: (formattedDate == currentDateFormatted)
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
                PopupTextFieldItems(
                  textEditingController: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(signed: true),
                  inputFormatters: [
                    // FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}')),
                  ],
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
                      child: InkWell(
                        onTap: () {
                          if (categoryValueFromListItem != null) {
                            final transactionVal = TransactionModel(
                              dateTime: selectedDate.toString(),
                              amount: int.parse(amountController.text),
                              note: (noteController.text.trim() == "")
                                  ? null
                                  : noteController.text.trim(),
                              categoryModel: CategoryModel(
                                transactionType: categoryValueFromListItem
                                    ?.transactionType as String,
                                isIncome:
                                    categoryValueFromListItem?.isIncome as bool,
                                colorsValue: categoryValueFromListItem
                                    ?.colorsValue as int,
                              ),
                            );
                            blocTransaction.changeData(transactionVal,
                                categoryValueFromListItem?.isIncome as bool);
                          }
                          context.pop();
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const PopupTextFieldTitle(
                  title: "Category",
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: SizedBox(
                            height: 400,
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        for (final listItem
                                            in blocCategories.listItems)
                                          ListTile(
                                            onTap: () {
                                              setState(() {
                                                categoryItem = listItem
                                                    .transactionType
                                                    .toString();
                                                categoryValueFromListItem =
                                                    listItem;
                                              });
                                              context.pop();
                                            },
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  listItem.isIncome == true
                                                      ? Colors.blue
                                                      : Colors.red,
                                              child: listItem.isIncome == true
                                                  ? const Icon(
                                                      Icons.addchart,
                                                      color: Colors.white,
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .highlight_remove_sharp,
                                                      color: Colors.white,
                                                    ),
                                            ),
                                            //
                                            title: Text(
                                              listItem.transactionType,
                                            ),
                                          ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.blueAccent,
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return const CategoryAddOrEditDialog(
                                                        editMode: false,
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const Text(
                                                  "+ Add Cateory",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: PopupCategoryItems(
                    title: () {
                      if (categoryItem == null) {
                        return "Select Category";
                      } else {
                        return categoryItem ?? "Select Category";
                      }
                    }(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const PopupTextFieldTitle(
                  title: "Note",
                ),
                PopupTextFieldItems(
                  textEditingController: noteController,
                  hintText: "Note(Optional)",
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}