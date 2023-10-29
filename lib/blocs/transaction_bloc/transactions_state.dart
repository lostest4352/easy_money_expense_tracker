part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsState {}

final class TransactionsInitial extends TransactionsState {}

class TransactionsAddState extends TransactionsState {}

class TransactionsEditState extends TransactionsState {}

class TransactionsDeleteState extends TransactionsState {}
