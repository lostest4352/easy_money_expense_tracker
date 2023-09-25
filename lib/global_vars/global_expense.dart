import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';

//
final listItems = [
  {"type": "Clothing", "income": false},
  {"type": "Entertainment", "income": false},
  {"type": "Health", "income": false},
  {"type": "Fuel", "income": false},
  {"type": "Food", "income": false},
  {"type": "Salary", "income": true},
  {"type": "Bonus", "income": true},
  {"type": "Wages", "income": true},
];

//
int totalExpenses = 0;
int totalIncome = 0;

List<TransactionModel> transactionList = [
  TransactionModel(
    year: 2023,
    dateTime: "September 24, Sunday",
    amount: 6000,
    category: "Salary",
    isIncome: true,
    colorsValue: Colors.red.value,
  ),
  TransactionModel(
    year: 2023,
    dateTime: "September 24, Sunday",
    amount: 5000,
    category: "Food",
    isIncome: false,
    colorsValue: Colors.green.value,
  ),
  TransactionModel(
    year: 2023,
    dateTime: "September 24, Sunday",
    amount: 7000,
    category: "Wages",
    isIncome: true,
    colorsValue: Colors.blue.value,
  ),
  TransactionModel(
    year: 2023,
    dateTime: "September 24, Sunday",
    amount: 2000,
    category: "Clothing",
    isIncome: false,
    colorsValue: Colors.yellow.value,
    note: "Bought a t-shirt",
  ),
  TransactionModel(
    year: 2023,
    dateTime: "September 24, Sunday",
    amount: 7000,
    category: "Bonus",
    isIncome: true,
    colorsValue: Colors.orange.value,
  ),
  TransactionModel(
    year: 2023,
    dateTime: "September 24, Sunday",
    amount: 7000,
    category: "Lottery",
    isIncome: true,
    colorsValue: Colors.deepPurple.value,
  ),
];

void getValue() {
  for (final transaction in transactionList) {
    if (transaction.isIncome == true) {
      totalIncome += transaction.amount;
    } else {
      totalExpenses += transaction.amount;
    }
  }
}
