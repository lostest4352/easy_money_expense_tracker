part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class AddCategoryState extends CategoryState {}

class EditCategoryState extends CategoryState {}

class DeleteCategoryState extends CategoryState {}

class EditNotAllowedState extends CategoryState {}
