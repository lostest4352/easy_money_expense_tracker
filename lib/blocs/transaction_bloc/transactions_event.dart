part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsEvent {}

class AddTransactionEvent extends TransactionsEvent {
 final TransactionModelIsar transactionModelIsar;

  AddTransactionEvent({required this.transactionModelIsar});
}

class EditTransactionEvent extends TransactionsEvent {
  final int selectedTransactionModelId;
  final int amount;
  final String dateTime;
  final String? note;
  //
  final String transactionType;
  final bool isIncome;
  final int colorsValue;

  EditTransactionEvent({
    required this.selectedTransactionModelId,
    required this.amount,
    required this.dateTime,
    required this.note,
    required this.transactionType,
    required this.isIncome,
    required this.colorsValue,
  });
}

class DeleteTransactionEvent extends TransactionsEvent {
  final TransactionModelIsar? widgetTransactionModelIsar;

  DeleteTransactionEvent({
    required this.widgetTransactionModelIsar,
  });
}
