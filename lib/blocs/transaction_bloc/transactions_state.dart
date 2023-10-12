part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsState {}

final class TransactionsInitial extends TransactionsState {}

class AddTransactionState extends TransactionsState {
  final int totalExpenses;
  final int totalIncome;
  final List<TransactionModel> transactionList;
  final Function(TransactionModel transactionModel, bool isIncome) changeData;
  final Function(DateTime date) calculateMonthsData;
  AddTransactionState({
    required this.totalExpenses,
    required this.totalIncome,
    required this.transactionList,
    required this.changeData,
    required this.calculateMonthsData,
  });
}
