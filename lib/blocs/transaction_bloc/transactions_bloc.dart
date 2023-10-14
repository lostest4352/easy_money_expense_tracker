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
