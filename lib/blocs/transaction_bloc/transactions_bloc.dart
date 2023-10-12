import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/category_model.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:intl/intl.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  //
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

  //
  TransactionsBloc() : super(TransactionsInitial()) {
    on<AddTransactionEvent>((event, emit) {
      //
      emit(
        AddTransactionState(
          transactionList: transactionList,
          totalExpenses: totalExpenses,
          totalIncome: totalIncome,
          changeData: changeData,
          calculateMonthsData: calculateMonthsData,
        ),
      );
    });
  }

  // void getValue() {
  //   for (final transaction in transactionList) {
  //     if (transaction.categoryModel.isIncome == true) {
  //       totalIncome += transaction.amount;
  //     } else {
  //       totalExpenses += transaction.amount;
  //     }
  //     add(AddTransactionEvent());
  //   }
  // }

  void changeData(TransactionModel transactionModel, bool isIncome) {
    transactionList.add(transactionModel);
    if (isIncome == true) {
      totalIncome += transactionModel.amount;
    } else {
      totalExpenses += transactionModel.amount;
    }
    // add(ChangeIncomeExpensesEvent());
    add(AddTransactionEvent());
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
}
