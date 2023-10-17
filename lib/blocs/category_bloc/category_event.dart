part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {}

class EditCategoryEvent extends CategoryEvent {}

class DeleteCategoryEvent extends CategoryEvent {}
