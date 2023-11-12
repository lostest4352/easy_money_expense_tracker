part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoadedState extends CategoryState with EquatableMixin {
  final List<CategoryModelIsar>? listOfCategoryData;

  CategoryLoadedState({required this.listOfCategoryData});
  
  @override
  List<Object?> get props => [listOfCategoryData];
}

final class CategoryAddDefaultItemsState extends CategoryState {}

final class DisallowModificationState extends CategoryState {}
