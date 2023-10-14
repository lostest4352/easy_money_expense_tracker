part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsState {}

final class TransactionsInitial extends TransactionsState {}

class AddTransactionState extends TransactionsState {
  final Function(TransactionModel transactionModel, bool isIncome) changeData;
  final Function(DateTime date) calculateMonthsData;

  AddTransactionState({
    required this.changeData,
    required this.calculateMonthsData,
  });
}
