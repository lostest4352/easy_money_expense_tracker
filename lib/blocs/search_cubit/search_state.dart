part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoadedState extends SearchState {
  final List<TransactionModelIsar>? listOfTransactionData;

  const SearchLoadedState({required this.listOfTransactionData});
}
