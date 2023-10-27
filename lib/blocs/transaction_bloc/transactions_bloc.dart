import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/database/isar_service.dart';
import 'package:isar/isar.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  //
  // TransactionModelIsar transactionModelIsar = TransactionModelIsar();
  final IsarService isarService = IsarService();
  //
  TransactionsBloc() : super(TransactionsInitial()) {
    on<AddTransactionEvent>((event, emit) async {
      // transactionList.add(event.transactionModel);
      final isar = await isarService.isarDB;
      final transactionModelIsarList =
          await isar.transactionModelIsars.where().findAll();

      isar.writeTxnSync(() async {
        isar.transactionModelIsars.putSync(event.transactionModelIsar);
      });
      calculateIncome(transactionModelIsarList);
      emit(AddTransactionState());
    });

    on<EditTransactionEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      final selectedUserModel = await isar.transactionModelIsars
          .get(event.selectedTransactionModelId);
      selectedUserModel?.amount = event.amount;
      selectedUserModel?.categoryModelIsar.value = event.categoryModelIsar;
      selectedUserModel?.dateTime = event.dateTime;
      selectedUserModel?.note = event.note;
      //
      final transactionModelIsarList =
          await isar.transactionModelIsars.where().findAll();
      isar.writeTxnSync(() async {
        if (selectedUserModel != null) {
          isar.transactionModelIsars.putSync(selectedUserModel);
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
      if (transaction.categoryModelIsar.value?.isIncome == true) {
        localIncome += transaction.amount;
      } else {
        localExpense += transaction.amount;
      }
    }
    totalIncome = localIncome;
    totalExpenses = localExpense;
  }
}
