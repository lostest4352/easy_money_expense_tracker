import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/category_model.dart';
import 'package:flutter_expense_tracker/models/dropdown_colors.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<AddCategoryEvent>((event, emit) {
      emit(AddCategoryState());
    });
  }

  void addCategory(String transactionType, bool isIncome, int colorsValue) {
    listItems.add(
      CategoryModel(
        transactionType: transactionType,
        isIncome: isIncome,
        colorsValue: colorsValue,
      ),
    );
    add(AddCategoryEvent());
  }

  void removeCategory() {
    // listItems.remove(value);
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
