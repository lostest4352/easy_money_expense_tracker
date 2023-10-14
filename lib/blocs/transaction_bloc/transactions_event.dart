part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsEvent {}

class AddTransactionEvent extends TransactionsEvent {
  final int totalExpenses;
  final int totalIncome;
  final List<TransactionModel> transactionList;

  AddTransactionEvent({
    required this.totalExpenses,
    required this.totalIncome,
    required this.transactionList,
  });
}
