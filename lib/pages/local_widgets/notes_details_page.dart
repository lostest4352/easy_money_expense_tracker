import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class NotesDetailsPage extends StatefulWidget {
  final TransactionModel transaction;
  const NotesDetailsPage({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  State<NotesDetailsPage> createState() => _NotesDetailsPageState();
}

class _NotesDetailsPageState extends State<NotesDetailsPage> {
  final TextEditingController amountEditingController = TextEditingController();
  final TextEditingController noteEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    amountEditingController.text = widget.transaction.amount.toString();
    noteEditingController.text = widget.transaction.note ?? "";
  }

  @override
  void dispose() {
    amountEditingController.dispose();
    noteEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        // final blocTransaction = context.read<TransactionsBloc>();
        final dateFormatDay = DateFormat("MMMM dd, y, EEEE")
            .format(DateTime.parse(widget.transaction.dateTime));
        final dateFormatTime = DateFormat('h:mm a')
            .format(DateTime.parse(widget.transaction.dateTime));
        return Dialog(
          child: Container(
            color: Colors.black38,
            height: 300,
            child: ListView(
              // mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(dateFormatDay.toString()),
                  subtitle: Text("At ${dateFormatTime.toString()}"),
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text("Amount: "),
                    ),
                    const Spacer(),
                    const Text("Rs. "),
                    Container(
                      padding: const EdgeInsets.only(right: 8),
                      width: 80,
                      child: TextField(
                        controller: amountEditingController,
                        // enabled: false,
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Text(widget.transaction.categoryModel.transactionType),
                  subtitle: () {
                    if (widget.transaction.categoryModel.isIncome) {
                      return const Text("Income");
                    } else {
                      return const Text("Expense");
                    }
                  }(),
                ),
                Card(
                  child: Column(
                    children: [
                      // ignore: prefer_const_constructors
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: const Align(
                            alignment: Alignment.topLeft,
                            child: Text('Notes:')),
                      ),
                      TextField(
                        minLines: 1,
                        maxLines: 20,
                        controller: noteEditingController,
                        decoration: InputDecoration(
                          hintText: () {
                            if (widget.transaction.note == null ||
                                widget.transaction.note == "") {
                              return "No notes";
                            }
                          }(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {},
                        child: const Text("Update"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
