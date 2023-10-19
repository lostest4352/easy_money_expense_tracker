import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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
  int totalExpenses = 0;
  int totalIncome = 0;

  List<TransactionModel> transactionList = [];

  void changeData(TransactionModel transactionModel) {
    transactionList.add(transactionModel);
    calculateIncome();
    add(AddTransactionEvent());
  }

  void calculateIncome() {
    int localIncome = 0;
    int localExpense = 0;
    for (final transaction in transactionList) {
      if (transaction.categoryModel.isIncome == true) {
        localIncome += transaction.amount;
      } else {
        localExpense += transaction.amount;
      }
    }
    totalIncome = localIncome;
    totalExpenses = localExpense;
  }

  void editData(
      {required TransactionModel transactionModel,
      required TransactionModel widgetTransaction}) {
    widgetTransaction.amount = transactionModel.amount;
    widgetTransaction.categoryModel = transactionModel.categoryModel;
    widgetTransaction.note = transactionModel.note;
    calculateIncome();
    add(AddTransactionEvent());
  }
}
