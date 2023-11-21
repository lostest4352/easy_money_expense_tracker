import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/database/isar_service.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  StreamSubscription? _streamSubscription;
  final IsarService isarService;
  SearchCubit({required this.isarService}) : super(SearchInitial());

  void searchClicked(String searchPattern) {
    _streamSubscription = isarService
        .listenTransactionSearchItem(searchPattern: searchPattern)
        .listen((event) {
      emit(SearchLoadedState(listOfTransactionData: event));
      _streamSubscription?.cancel();
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
