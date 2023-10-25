import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  //
  TransactionsBloc() : super(TransactionsInitial()) {
    on<AddTransactionEvent>((event, emit) {
      transactionList.add(event.transactionModel);
      calculateIncome();
      emit(AddTransactionState());
    });

    on<EditTransactionEvent>((event, emit) {
      event.widgetTransaction.amount = event.transactionModel.amount;
      event.widgetTransaction.categoryModel =
          event.transactionModel.categoryModel;
      event.widgetTransaction.note = event.transactionModel.note;
      calculateIncome();
      emit(EditTransactionState());
    });

    on<DeleteTransactionEvent>((event, emit) {
      transactionList.remove(event.widgetTransaction);
      calculateIncome();
      emit(DeleteTransactionState());
    });
  }

  //
  int totalExpenses = 0;
  int totalIncome = 0;

  List<TransactionModel> transactionList = [];

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
}
