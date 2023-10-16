part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {}
