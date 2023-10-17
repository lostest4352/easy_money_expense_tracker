part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class AddCategoryState extends CategoryState {}

final class EditCategoryState extends CategoryState {}

final class DeleteCategoryState extends CategoryState {}

final class DisallowModificationState extends CategoryState {}
