part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsEvent {}

class AddTransactionEvent extends TransactionsEvent {
  final TransactionModelIsar transactionModelIsar;

  AddTransactionEvent({
    required this.transactionModelIsar,
  });
}

class EditTransactionEvent extends TransactionsEvent {
  final int selectedTransactionModelId;
  final int amount;
  final CategoryModelIsar categoryModelIsar;
  final String dateTime;
  final String note;

  EditTransactionEvent({
    required this.selectedTransactionModelId,
    required this.amount,
    required this.categoryModelIsar,
    required this.dateTime,
    required this.note,
  });
}

class DeleteTransactionEvent extends TransactionsEvent {
  final TransactionModelIsar? widgetTransactionModelIsar;

  DeleteTransactionEvent({
    required this.widgetTransactionModelIsar,
  });
}
