import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../database/isar_classes.dart';

(int, int) calculateTotalIncomeOrExpenses(
    AsyncSnapshot<List<TransactionModelIsar>> snapshot) {
  int totalIncome = 0;
  int totalExpenses = 0;

  for (final transactionItem in snapshot.data!) {
    if (transactionItem.isIncome == true) {
      totalIncome += transactionItem.amount;
    } else {
      totalExpenses += transactionItem.amount;
    }
  }
  return (totalIncome, totalExpenses);
}

// In order to seperate listview by months
// int calculateMonthsData(
//     DateTime date, List<TransactionModelIsar> transactionList) {
//   int monthlyAmt = 0;

//   for (final transaction in transactionList) {
//     final passedTransactionDate = DateTime.parse(transaction.dateTime);
//     final formattedTransactionDate =
//         DateFormat("MMMM, y").format(passedTransactionDate);
//     //
//     final formattedPassedDate = DateFormat("MMMM, y").format(date);
//     //
//     if (formattedTransactionDate == formattedPassedDate) {
//       if (transaction.isIncome == true) {
//         monthlyAmt += transaction.amount;
//       } else {
//         monthlyAmt -= transaction.amount;
//       }
//     }
//   }
//   return monthlyAmt;
// }

// int calculateDayData(
//     DateTime date, List<TransactionModelIsar> transactionList) {
//   int monthlyAmt = 0;

//   for (final transaction in transactionList) {
//     final passedTransactionDate = DateTime.parse(transaction.dateTime);
//     final formattedTransactionDate =
//         DateFormat("d MMMM, y").format(passedTransactionDate);
//     //
//     final formattedPassedDate = DateFormat("d MMMM, y").format(date);
//     //
//     if (formattedTransactionDate == formattedPassedDate) {
//       if (transaction.isIncome == true) {
//         monthlyAmt += transaction.amount;
//       } else {
//         monthlyAmt -= transaction.amount;
//       }
//     }
//   }
//   return monthlyAmt;
// }

(int, int) calculateSelectionData(List<TransactionModelIsar> transactionList) {
  int selectionIncome = 0;
  int selectionExpense = 0;

  for (final transaction in transactionList) {
    if (transaction.isIncome == true) {
      selectionIncome += transaction.amount;
    } else {
      selectionExpense -= transaction.amount;
    }
  }
  return (selectionIncome, selectionExpense);
}
