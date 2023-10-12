// import 'package:flutter/material.dart';
// import 'package:flutter_expense_tracker/models/category_model.dart';
// import 'package:flutter_expense_tracker/models/transaction_model.dart';
// import 'package:intl/intl.dart';

// // TODO If category deleted, move the values under other expenses/income

// final listItems = [
//   CategoryModel(
//     transactionType: "Clothing",
//     isIncome: false,
//     colorsValue: Colors.greenAccent.value,
//   ),
//   CategoryModel(
//     transactionType: "Entertainment",
//     isIncome: false,
//     colorsValue: Colors.red.value,
//   ),
//   CategoryModel(
//     transactionType: "Health",
//     isIncome: false,
//     colorsValue: Colors.blue.value,
//   ),
//   CategoryModel(
//     transactionType: "Fuel",
//     isIncome: false,
//     colorsValue: Colors.yellowAccent.value,
//   ),
//   CategoryModel(
//     transactionType: "Food",
//     isIncome: false,
//     colorsValue: Colors.deepOrange.value,
//   ),
//   CategoryModel(
//     transactionType: "Salary",
//     isIncome: true,
//     colorsValue: Colors.blue.value,
//   ),
//   CategoryModel(
//     transactionType: "Bonus",
//     isIncome: true,
//     colorsValue: Colors.red.value,
//   ),
//   CategoryModel(
//     transactionType: "Wages",
//     isIncome: true,
//     colorsValue: Colors.green.value,
//   ),
// ];

// //
// int totalExpenses = 0;
// int totalIncome = 0;

// List<TransactionModel> transactionList = [];

// //
// void getValue() {
//   for (final transaction in transactionList) {
//     if (transaction.categoryModel.isIncome == true) {
//       totalIncome += transaction.amount;
//     } else {
//       totalExpenses += transaction.amount;
//     }
//   }
// }


