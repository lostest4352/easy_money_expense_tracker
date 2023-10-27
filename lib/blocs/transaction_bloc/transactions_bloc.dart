import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/database/isar_service.dart';
import 'package:isar/isar.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final IsarService isarService = IsarService();
  //
  TransactionsBloc() : super(TransactionsInitial()) {
    on<AddTransactionEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      final transactionModelIsarList =
          await isar.transactionModelIsars.where().findAll();

      isar.writeTxn(() async {
        // final enteredCategoryModel = event.categoryModelIsar;
        await isar.transactionModelIsars.put(event.transactionModelIsar);
        // await isar.transactionModelIsars.put(enteredTransaction);
      });
      calculateIncome(transactionModelIsarList);
      emit(AddTransactionState());
    });

    on<EditTransactionEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      final selectedUserModel = await isar.transactionModelIsars
          .get(event.selectedTransactionModelId);
      selectedUserModel?.amount = event.amount;
      selectedUserModel?.dateTime = event.dateTime;
      selectedUserModel?.note = event.note;
      //
      selectedUserModel?.transactionType = event.transactionType;
      selectedUserModel?.isIncome = event.isIncome;
      selectedUserModel?.colorsValue = event.colorsValue;
      //
      final transactionModelIsarList =
          await isar.transactionModelIsars.where().findAll();
      isar.writeTxn(() async {
        if (selectedUserModel != null) {
          await isar.transactionModelIsars.put(selectedUserModel);
        }
      });
      calculateIncome(transactionModelIsarList);
      emit(EditTransactionState());
    });

    on<DeleteTransactionEvent>((event, emit) async {
      // transactionList.remove(event.widgetTransaction);
      final isar = await isarService.isarDB;
      final transactionModelIsarList =
          await isar.transactionModelIsars.where().findAll();
      isar.writeTxn(() async {
        isar.transactionModelIsars.delete(event.widgetTransactionModelIsar!.id);
      });
      calculateIncome(transactionModelIsarList);
      emit(DeleteTransactionState());
    });
  }

  //
  int totalExpenses = 0;
  int totalIncome = 0;

  // List<TransactionModel> transactionList = []; // TODO

  void calculateIncome(List<TransactionModelIsar> transactionModelIsarList) {
    int localIncome = 0;
    int localExpense = 0;
    for (final transaction in transactionModelIsarList) {
      if (transaction.isIncome == true) {
        localIncome += transaction.amount;
      } else {
        localExpense += transaction.amount;
      }
    }
    totalIncome = localIncome;
    totalExpenses = localExpense;
  }
}
