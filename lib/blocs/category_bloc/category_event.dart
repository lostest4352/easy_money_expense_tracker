part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class AddCategoryEvent extends CategoryEvent {
  final CategoryModelIsar categoryModelIsars;

  AddCategoryEvent({required this.categoryModelIsars});
}

final class EditCategoryEvent extends CategoryEvent {
  final CategoryModelIsar selectedCategoryModelIsar;
  final int selectedCategoryModelId;
  final String transactionType;
  final bool isIncome;
  final int colorsValue;

  EditCategoryEvent(
      {required this.selectedCategoryModelIsar,
      required this.selectedCategoryModelId,
      required this.transactionType,
      required this.isIncome,
      required this.colorsValue});
}

final class DeleteCategoryEvent extends CategoryEvent {
  final CategoryModelIsar selectedCategoryModelIsar;

  DeleteCategoryEvent({required this.selectedCategoryModelIsar});
}
