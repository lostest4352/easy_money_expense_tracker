part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsState {}

final class TransactionsInitial extends TransactionsState {}

final class TransactionsLoadedState extends TransactionsState {
  final List<TransactionModelIsar>? listOfTransactionData;

  TransactionsLoadedState({required this.listOfTransactionData});
}
