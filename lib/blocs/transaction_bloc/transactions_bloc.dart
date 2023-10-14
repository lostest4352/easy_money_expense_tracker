import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/category_model.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  //
  TransactionsBloc() : super(TransactionsInitial()) {
    on<AddTransactionEvent>((event, emit) {
      emit(AddTransactionState());
    });
  }

  //
  final listItems = [
    CategoryModel(
      transactionType: "Clothing",
      isIncome: false,
      colorsValue: Colors.deepPurple.value,
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
      colorsValue: Colors.yellow.value,
    ),
    CategoryModel(
      transactionType: "Food",
      isIncome: false,
      colorsValue: Colors.green.value,
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
    CategoryModel(
      transactionType: "Gifts",
      isIncome: true,
      colorsValue: Colors.purple.value,
    ),
  ];

  //
  int totalExpenses = 0;
  int totalIncome = 0;

  List<TransactionModel> transactionList = [];

  void changeData(TransactionModel transactionModel, bool isIncome) {
    transactionList.add(transactionModel);
    if (isIncome == true) {
      totalIncome += transactionModel.amount;
    } else {
      totalExpenses += transactionModel.amount;
    }
    add(AddTransactionEvent());
  }
}
