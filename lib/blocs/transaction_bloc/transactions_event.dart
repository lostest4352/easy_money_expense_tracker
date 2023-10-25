part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsEvent {}

class AddTransactionEvent extends TransactionsEvent {
  final TransactionModel transactionModel;

  AddTransactionEvent({
    required this.transactionModel,
  });
}

class EditTransactionEvent extends TransactionsEvent {
  final TransactionModel transactionModel;
  final TransactionModel widgetTransaction;

  EditTransactionEvent({
    required this.transactionModel,
    required this.widgetTransaction,
  });
}

class DeleteTransactionEvent extends TransactionsEvent {
  final TransactionModel? widgetTransaction;

  DeleteTransactionEvent({required this.widgetTransaction});
}
