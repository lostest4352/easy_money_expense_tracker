part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class ModifyCategoryEvent extends CategoryEvent {
  final BuildContext context;
  final bool editMode;
  final String transactionType;
  final bool isIncome;
  final int colorsValue;
  final List<TransactionModel> transactionList;
  final CategoryModel? selectedListItem;

  ModifyCategoryEvent({
    required this.context,
    required this.editMode,
    required this.transactionType,
    required this.isIncome,
    required this.colorsValue,
    required this.transactionList,
    this.selectedListItem,
  });
}
