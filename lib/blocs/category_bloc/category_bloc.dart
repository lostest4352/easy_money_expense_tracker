import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/database/isar_service.dart';
import 'package:flutter_expense_tracker/models/dropdown_colors.dart';
import 'package:isar/isar.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  //
  final IsarService isarService = IsarService();

  //
  CategoryBloc() : super(CategoryInitial()) {
    on<AddCategoryEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      isar.writeTxn(() async {
        await isar.categoryModelIsars.put(event.categoryModelIsars);
      });
      emit(AddCategoryState());
    });

    on<EditCategoryEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      final selectedCategoryModel =
          await isar.categoryModelIsars.get(event.selectedCategoryModelId);
      selectedCategoryModel?.transactionType = event.transactionType;
      selectedCategoryModel?.isIncome = event.isIncome;
      selectedCategoryModel?.colorsValue = event.colorsValue;
      await isar.writeTxn(() async {
        final filteredTransactionModelList = await isar.transactionModelIsars
            .where()
            .filter()
            .transactionTypeEqualTo(
                event.selectedCategoryModelIsar.transactionType)
            .findAll();
        if (filteredTransactionModelList.isEmpty) {
          if (selectedCategoryModel != null) {
            await isar.categoryModelIsars.put(selectedCategoryModel);
            emit(EditCategoryState());
          }
        } else {
          emit(DisallowModificationState());
        }
      });
    });

    on<DeleteCategoryEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      await isar.writeTxn(() async {
        final filteredTransactionModelList = await isar.transactionModelIsars
            .where()
            .filter()
            .transactionTypeEqualTo(
                event.selectedCategoryModelIsar.transactionType)
            .findAll();
        if (filteredTransactionModelList.isEmpty) {
          await isar.categoryModelIsars
              .delete(event.selectedCategoryModelIsar.id);
          emit(DeleteCategoryState());
        } else {
          emit(DisallowModificationState());
        }
      });
    });

    on<AddDefaultItemsEvent>((event, emit) async {
      final isar = await isarService.isarDB;
      await isar.writeTxn(() async {
        await isar.categoryModelIsars.putAll(defaultListItems);
      });
      emit(AddDefaultItemsState());
    });
  }

  final defaultListItems = [
    CategoryModelIsar()
      ..transactionType = "Clothing"
      ..isIncome = false
      ..colorsValue = purpleColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Entertainment"
      ..isIncome = false
      ..colorsValue = redColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Health"
      ..isIncome = false
      ..colorsValue = blueColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Fuel"
      ..isIncome = false
      ..colorsValue = yellowColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Food"
      ..isIncome = false
      ..colorsValue = greenColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Salary"
      ..isIncome = true
      ..colorsValue = blueColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Bonus"
      ..isIncome = true
      ..colorsValue = redColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Wages"
      ..isIncome = true
      ..colorsValue = greenColor.colorsValue,
    CategoryModelIsar()
      ..transactionType = "Gifts"
      ..isIncome = true
      ..colorsValue = purpleColor.colorsValue,
  ];
}
