import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:intl/intl.dart';

class NotesDetailsPage extends StatelessWidget {
  final TransactionModel transaction;
  const NotesDetailsPage({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        // final blocTransaction = context.read<TransactionsBloc>();
        final thisdate = DateFormat("MMMM dd, y")
            .format(DateTime.parse(transaction.dateTime));
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(thisdate.toString()),
              ),
              ListTile(
                title: Text("Amount: Rs.${transaction.amount}"),
              ),
              ListTile(
                title: Text(transaction.categoryModel.transactionType),
                subtitle: () {
                  if (transaction.categoryModel.isIncome) {
                    return const Text("Income");
                  } else {
                    return const Text("Expense");
                  }
                }(),
              ),
              ListTile(
                title: Text(transaction.note ?? "No notes"),
              ),
            ],
          ),
        );
      },
    );
  }
}
