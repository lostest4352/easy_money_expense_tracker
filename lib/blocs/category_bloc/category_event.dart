part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class AddOrEditCategoryEvent extends CategoryEvent {
  final BuildContext context;
  final bool editMode;
  final String transactionType;
  final bool isIncome;
  final int colorsValue;
  final List<TransactionModel> transactionList;
  final CategoryModel? selectedListItem;

  AddOrEditCategoryEvent({
    required this.context,
    required this.editMode,
    required this.transactionType,
    required this.isIncome,
    required this.colorsValue,
    required this.transactionList,
    this.selectedListItem,
  });
}

final class DeleteCategoryEvent extends CategoryEvent {
  final BuildContext context;
  final CategoryModel selectedListItem;
  final List<TransactionModel> transactionList;

  DeleteCategoryEvent({
    required this.context,
    required this.selectedListItem,
    required this.transactionList,
  });
}
