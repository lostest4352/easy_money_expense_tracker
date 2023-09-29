import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/category_model.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:intl/intl.dart';

// TODO If category deleted, move the values under other expenses/income

final listItems = [
  CategoryModel(
    transactionType: "Clothing",
    isIncome: false,
    colorsValue: Colors.greenAccent.value,
  ),
  CategoryModel(
    transactionType: "Entertainment",
    isIncome: false,
    colorsValue: Colors.red.value,
  ),
  CategoryModel(
    transactionType: "Health",
    isIncome: false,
    colorsValue: Colors.blue.value,
  ),
  CategoryModel(
    transactionType: "Fuel",
    isIncome: false,
    colorsValue: Colors.yellowAccent.value,
  ),
  CategoryModel(
    transactionType: "Food",
    isIncome: false,
    colorsValue: Colors.deepOrange.value,
  ),
  CategoryModel(
    transactionType: "Salary",
    isIncome: true,
    colorsValue: Colors.blue.value,
  ),
  CategoryModel(
    transactionType: "Bonus",
    isIncome: true,
    colorsValue: Colors.red.value,
  ),
  CategoryModel(
    transactionType: "Wages",
    isIncome: true,
    colorsValue: Colors.green.value,
  ),
];

//
int totalExpenses = 0;
int totalIncome = 0;

List<TransactionModel> transactionList = [];
// List<TransactionModel> transactionList = [
//   TransactionModel(
//     year: 2023,
//     dateTime: "September 24, Sunday",
//     amount: 6000,
//     category: "Salary",
//     isIncome: true,
//     colorsValue: Colors.blue.value,
//   ),
//   TransactionModel(
//     year: 2023,
//     dateTime: "September 24, Sunday",
//     amount: 5000,
//     category: "Food",
//     isIncome: false,
//     colorsValue: Colors.deepOrange.value,
//   ),
//   TransactionModel(
//     year: 2023,
//     dateTime: "September 24, Sunday",
//     amount: 7000,
//     category: "Wages",
//     isIncome: true,
//     colorsValue: Colors.green.value,
//   ),
//   TransactionModel(
//     year: 2023,
//     dateTime: "September 24, Sunday",
//     amount: 2000,
//     category: "Clothing",
//     isIncome: false,
//     colorsValue: Colors.greenAccent.value,
//     note: "Bought a t-shirt",
//   ),
//   TransactionModel(
//     year: 2023,
//     dateTime: "September 24, Sunday",
//     amount: 7000,
//     category: "Bonus",
//     isIncome: true,
//     colorsValue: Colors.orange.value,
//   ),
//   TransactionModel(
//     year: 2023,
//     dateTime: "September 24, Sunday",
//     amount: 7000,
//     category: "Lottery",
//     isIncome: true,
//     colorsValue: Colors.deepPurple.value,
//   ),
// ];

void getValue() {
  for (final transaction in transactionList) {
    if (transaction.categoryModel.isIncome == true) {
      totalIncome += transaction.amount;
    } else {
      totalExpenses += transaction.amount;
    }
  }
}

// mm dateformat is minutes. MM is month
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
