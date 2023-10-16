import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/category_model.dart';

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

  //
  final listItems = [
    CategoryModel(
      transactionType: "Clothing",
      isIncome: false,
      colorsValue: Colors.deepPurple.value,
    ),
    CategoryModel(
      transactionType: "Entertainment",
      isIncome: false,
      colorsValue: Colors.red.value,
    ),
    CategoryModel(
      transactionType: "Health",
      isIncome: false,
      colorsValue: Colors.blue.value,
    ),
    CategoryModel(
      transactionType: "Fuel",
      isIncome: false,
      colorsValue: Colors.yellow.value,
    ),
    CategoryModel(
      transactionType: "Food",
      isIncome: false,
      colorsValue: Colors.green.value,
    ),
    CategoryModel(
      transactionType: "Salary",
      isIncome: true,
      colorsValue: Colors.blue.value,
    ),
    CategoryModel(
      transactionType: "Bonus",
      isIncome: true,
      colorsValue: Colors.red.value,
    ),
    CategoryModel(
      transactionType: "Wages",
      isIncome: true,
      colorsValue: Colors.green.value,
    ),
    CategoryModel(
      transactionType: "Gifts",
      isIncome: true,
      colorsValue: Colors.purple.value,
    ),
  ];
}
