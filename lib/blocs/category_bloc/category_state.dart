part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryAddState extends CategoryState {}

final class CategoryEditState extends CategoryState {}

final class CategoryDeleteState extends CategoryState {}

final class CategoryDisallowModificationState extends CategoryState {}

final class CategoryAddDefaultItemsState extends CategoryState {}
