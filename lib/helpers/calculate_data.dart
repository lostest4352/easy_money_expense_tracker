// mm dateformat is minutes. MM is month
import 'package:flutter_expense_tracker/global_vars/global_expense.dart';
import 'package:intl/intl.dart';

int calculateMonthsData(DateTime date) {
  int monthlyAmt = 0;

  for (final transaction in transactionList) {
    final passedTransactionDate = DateTime.parse(transaction.dateTime);
    final formattedTransactionDate =
        DateFormat("MMMM, y").format(passedTransactionDate);
    //
    final formattedPassedDate = DateFormat("MMMM, y").format(date);
    //
    if (formattedTransactionDate == formattedPassedDate) {
      if (transaction.categoryModel.isIncome == true) {
        monthlyAmt += transaction.amount;
      } else {
        monthlyAmt -= transaction.amount;
      }
    }
  }
  return monthlyAmt;
}