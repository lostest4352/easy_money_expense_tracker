import 'package:flutter/material.dart';

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
