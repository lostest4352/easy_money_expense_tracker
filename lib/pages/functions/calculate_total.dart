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

({int totalIncome, int totalExpense, int totalValue}) calculateTotalValue(
    List<TransactionModelIsar> transactionList) {
  int totalIncome = 0;
  int totalExpense = 0;
  int totalValue = 0;

  for (final transaction in transactionList) {
    if (transaction.isIncome == true) {
      totalIncome += transaction.amount;
    } else {
      totalExpense -= transaction.amount;
    }
  }
  totalValue = totalIncome + totalExpense;
  return (
    totalIncome: totalIncome,
    totalExpense: totalExpense,
    totalValue: totalValue
  );
}
