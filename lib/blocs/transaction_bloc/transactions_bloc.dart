import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/blocs/time_range_cubit/time_range_cubit.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/database/isar_service.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final IsarService isarService;

  TransactionsBloc({required this.isarService}) : super(TransactionsInitial()) {
    final currentTime = DateTime.now();

    on<TransactionsLoadedEvent>((event, emit) async {
      // All Time
      if (event.timeRangeState.buttonName == "All Time") {
        final transactionListFromStream = isarService.listenTransactionData();
        await emit.forEach(
          transactionListFromStream,
          onData: (data) {
            return TransactionsLoadedState(listOfTransactionData: data);
          },
        );
      }
      // This Month
      if (event.timeRangeState.buttonName == "This Month") {
        final transactionListFromStream =
            isarService.listenTransactionDateRange(
          startTime: DateTime(
            currentTime.year,
            currentTime.month,
            1,
          ).toString(),
          endTime: currentTime.toString(),
        );
        await emit.forEach(
          transactionListFromStream,
          onData: (data) {
            return TransactionsLoadedState(listOfTransactionData: data);
          },
        );
      }
      // Last Month
      if (event.timeRangeState.buttonName == "Last Month") {
        final transactionListFromStream =
            isarService.listenTransactionDateRange(
          startTime: DateTime(
            currentTime.year,
            currentTime.month - 1,
            1,
          ).toString(),
          endTime: DateTime(
            currentTime.year,
            currentTime.month,
            0,
          ).toString(),
        );
        await emit.forEach(
          transactionListFromStream,
          onData: (data) {
            return TransactionsLoadedState(listOfTransactionData: data);
          },
        );
      }
      // Last 3 Months
      if (event.timeRangeState.buttonName == "Last 3 Months") {
        final transactionListFromStream =
            isarService.listenTransactionDateRange(
          startTime: DateTime(
            currentTime.year,
            currentTime.month - 2,
            1,
          ).toString(),
          endTime: currentTime.toString(),
        );
        await emit.forEach(
          transactionListFromStream,
          onData: (data) {
            return TransactionsLoadedState(listOfTransactionData: data);
          },
        );
      }
      // Last 6 Months
      if (event.timeRangeState.buttonName == "Last 6 Months") {
        final transactionListFromStream =
            isarService.listenTransactionDateRange(
          startTime: DateTime(
            currentTime.year,
            currentTime.month - 5,
            1,
          ).toString(),
          endTime: currentTime.toString(),
        );
        await emit.forEach(
          transactionListFromStream,
          onData: (data) {
            return TransactionsLoadedState(listOfTransactionData: data);
          },
        );
      }
    });

    on<TransactionsAddEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      isar.writeTxn(() async {
        await isar.transactionModelIsars.put(event.transactionModelIsar);
      });
    });

    on<TransactionsEditEvent>((event, emit) async {
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
      isar.writeTxn(() async {
        if (selectedUserModel != null) {
          await isar.transactionModelIsars.put(selectedUserModel);
        }
      });
    });

    on<TransactionsDeleteEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      isar.writeTxn(() async {
        await isar.transactionModelIsars
            .delete(event.widgetTransactionModelIsar!.id);
      });
    });
  }
}
