part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsEvent {}

class TransactionsAddEvent extends TransactionsEvent {
  final TransactionModelIsar transactionModelIsar;

  TransactionsAddEvent({required this.transactionModelIsar});
}

class TransactionsEditEvent extends TransactionsEvent {
  final int selectedTransactionModelId;
  final int amount;
  final String dateTime;
  final String? note;
  //
  final String transactionType;
  final bool isIncome;
  final int colorsValue;

  TransactionsEditEvent({
    required this.selectedTransactionModelId,
    required this.amount,
    required this.dateTime,
    required this.note,
    required this.transactionType,
    required this.isIncome,
    required this.colorsValue,
  });
}

class TransactionsDeleteEvent extends TransactionsEvent {
  final TransactionModelIsar? widgetTransactionModelIsar;

  TransactionsDeleteEvent({
    required this.widgetTransactionModelIsar,
  });
}
