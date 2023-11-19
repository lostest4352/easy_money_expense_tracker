import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/database/isar_service.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  late StreamSubscription _streamSubscription;
  final IsarService isarService;
  SearchCubit({required this.isarService}) : super(SearchInitial());

  void searchClicked(String searchPattern) async {
    _streamSubscription = isarService
        .listenTransactionSearchItem(searchPattern: searchPattern)
        .listen((event) {
      emit(SearchLoadedState(listOfTransactionData: event));
      debugPrint(event.first.transactionType);
    });
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
