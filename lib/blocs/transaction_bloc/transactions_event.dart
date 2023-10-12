part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsEvent {}

class AddTransactionEvent extends TransactionsEvent {}
