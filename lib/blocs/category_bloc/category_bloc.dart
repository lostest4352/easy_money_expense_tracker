import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/category_model.dart';
import 'package:flutter_expense_tracker/models/dropdown_colors.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:go_router/go_router.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<AddOrEditCategoryEvent>((event, emit) {
      if (event.editMode == false) {
        listItems.add(CategoryModel(
            transactionType: event.transactionType,
            isIncome: event.isIncome,
            colorsValue: event.colorsValue));
        emit(AddCategoryState());
        event.context.pop();
      } else if (event.editMode == true) {
        bool found = false;
        for (final transaction in event.transactionList) {
          if (transaction.categoryModel.transactionType ==
              event.selectedListItem?.transactionType) {
            found = true;
            emit(DisallowModificationState());
          }
        }
        if (!found) {
          event.selectedListItem?.colorsValue = event.colorsValue;
          event.selectedListItem?.transactionType = event.transactionType;
          event.selectedListItem?.isIncome = event.isIncome;
          emit(EditCategoryState());
          event.context.pop();
        }
      }
    });

    on<DeleteCategoryEvent>((event, emit) {
      bool found = false;
      for (final transaction in event.transactionList) {
        if (transaction.categoryModel.transactionType ==
            event.selectedListItem.transactionType) {
          found = true;
          emit(DisallowModificationState());
        }
      }
      if (!found) {
        listItems.remove(event.selectedListItem);
        emit(EditCategoryState());
        event.context.pop();
      }
    });
  }

  //
  final listItems = [
    CategoryModel(
      transactionType: "Clothing",
      isIncome: false,
      colorsValue: purpleColor.colorsValue,
    ),
    CategoryModel(
      transactionType: "Entertainment",
      isIncome: false,
      colorsValue: redColor.colorsValue,
    ),
    CategoryModel(
      transactionType: "Health",
      isIncome: false,
      colorsValue: blueColor.colorsValue,
    ),
    CategoryModel(
      transactionType: "Fuel",
      isIncome: false,
      colorsValue: yellowColor.colorsValue,
    ),
    CategoryModel(
      transactionType: "Food",
      isIncome: false,
      colorsValue: greenColor.colorsValue,
    ),
    CategoryModel(
      transactionType: "Salary",
      isIncome: true,
      colorsValue: blueColor.colorsValue,
    ),
    CategoryModel(
      transactionType: "Bonus",
      isIncome: true,
      colorsValue: redColor.colorsValue,
    ),
    CategoryModel(
      transactionType: "Wages",
      isIncome: true,
      colorsValue: greenColor.colorsValue,
    ),
    CategoryModel(
      transactionType: "Gifts",
      isIncome: true,
      colorsValue: purpleColor.colorsValue,
    ),
  ];
}
