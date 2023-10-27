import 'package:flutter/material.dart';

import '../../database/isar_classes.dart';

(int, int) calculateTotalIncomeOrExpenses(AsyncSnapshot<List<TransactionModelIsar>> snapshot) {
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