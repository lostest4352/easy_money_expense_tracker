import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/database/isar_service.dart';
import 'package:isar/isar.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  //
  final IsarService isarService = IsarService();

  //
  CategoryBloc() : super(CategoryInitial()) {
    // on<AddOrEditCategoryEvent>((event, emit) async {
    //   final isar = await isarService.isarDB;
    //   final categoryModelIsarList =
    //       await isar.categoryModelIsars.where().findAll();

    //   if (event.editMode == false) {
    //     // listItems.add(CategoryModel(
    //     //     transactionType: event.transactionType,
    //     //     isIncome: event.isIncome,
    //     //     colorsValue: event.colorsValue));

    //     isar.writeTxn(() async {
    //       isar.categoryModelIsars.put(event.categoryModelIsars);
    //     });
    //     emit(AddCategoryState());
    //     if (event.context.mounted) {
    //       event.context.pop();
    //     }
    //   } else if (event.editMode == true) {
    //     bool found = false;
    //     for (final transaction in event.transactionIsarList) {
    //       if (transaction.categoryModelIsar.value?.transactionType ==
    //           event.selectedListItem?.transactionType) {
    //         found = true;
    //         emit(DisallowModificationState());
    //       }
    //     }
    //     if (!found) {
    //       event.selectedListItem?.colorsValue = event.colorsValue;
    //       event.selectedListItem?.transactionType = event.transactionType;
    //       event.selectedListItem?.isIncome = event.isIncome;
    //       emit(EditCategoryState());
    //       event.context.pop();
    //     }
    //   }
    // });

    on<AddCategoryEvent>((event, emit) async {
      final isar = await isarService.isarDB;

      isar.writeTxn(() async {
        isar.categoryModelIsars.put(event.categoryModelIsars);
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
      isar.writeTxn(() async {
        // if (selectedCategoryModel != null) {
        //   isar.categoryModelIsars.put(selectedCategoryModel);
        // }
        // TODO
        final filteredTransactionModelList = await isar.transactionModelIsars
            .where()
            .filter()
            .transactionTypeEqualTo(
                event.selectedCategoryModelIsar.transactionType)
            // .categoryModelIsar((q) => q.transactionTypeEqualTo(
            //     event.selectedCategoryModelIsar.transactionType))
            .findAll();
        if (filteredTransactionModelList.isEmpty) {
          if (selectedCategoryModel != null) {
            isar.categoryModelIsars.put(selectedCategoryModel);
          }
        }
      });
    });

    on<DeleteCategoryEvent>((event, emit) async {
      // bool found = false;
      // for (final transaction in event.transactionList) {
      //   if (transaction.categoryModel.transactionType ==
      //       event.selectedListItem.transactionType) {
      //     found = true;
      //     emit(DisallowModificationState());
      //   }
      // }
      // if (!found) {
      //   listItems.remove(event.selectedListItem);
      //   emit(EditCategoryState());
      //   event.context.pop();
      // }

      final isar = await isarService.isarDB;
      isar.writeTxn(() async {
        // TODO
        final filteredTransactionModelList = await isar.transactionModelIsars
            .where()
            .filter()
            .transactionTypeEqualTo(
                event.selectedCategoryModelIsar.transactionType)
            // .categoryModelIsar((q) => q.transactionTypeEqualTo(
            //     event.selectedCategoryModelIsar.transactionType))
            .findAll();
        if (filteredTransactionModelList.isEmpty) {
          isar.transactionModelIsars.delete(event.selectedCategoryModelIsar.id);
        }
      });
    });
  }

  // TODO
  // final listItems = [
  //   CategoryModel(
  //     transactionType: "Clothing",
  //     isIncome: false,
  //     colorsValue: purpleColor.colorsValue,
  //   ),
  //   CategoryModel(
  //     transactionType: "Entertainment",
  //     isIncome: false,
  //     colorsValue: redColor.colorsValue,
  //   ),
  //   CategoryModel(
  //     transactionType: "Health",
  //     isIncome: false,
  //     colorsValue: blueColor.colorsValue,
  //   ),
  //   CategoryModel(
  //     transactionType: "Fuel",
  //     isIncome: false,
  //     colorsValue: yellowColor.colorsValue,
  //   ),
  //   CategoryModel(
  //     transactionType: "Food",
  //     isIncome: false,
  //     colorsValue: greenColor.colorsValue,
  //   ),
  //   CategoryModel(
  //     transactionType: "Salary",
  //     isIncome: true,
  //     colorsValue: blueColor.colorsValue,
  //   ),
  //   CategoryModel(
  //     transactionType: "Bonus",
  //     isIncome: true,
  //     colorsValue: redColor.colorsValue,
  //   ),
  //   CategoryModel(
  //     transactionType: "Wages",
  //     isIncome: true,
  //     colorsValue: greenColor.colorsValue,
  //   ),
  //   CategoryModel(
  //     transactionType: "Gifts",
  //     isIncome: true,
  //     colorsValue: purpleColor.colorsValue,
  //   ),
  // ];
}
