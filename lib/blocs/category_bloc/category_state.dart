part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoadedState extends CategoryState {
  final List<CategoryModelIsar>? listOfCategoryData;

  CategoryLoadedState({required this.listOfCategoryData});
}

final class CategoryAddDefaultItemsState extends CategoryState {}
