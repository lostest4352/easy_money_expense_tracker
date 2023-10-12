import 'dart:convert';

import 'package:flutter_expense_tracker/models/category_model.dart';

class PieChartModel {
  CategoryModel categoryModel;
  int amount;
  PieChartModel({
    required this.categoryModel,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryModel': categoryModel.toMap(),
      'amount': amount,
    };
  }

  factory PieChartModel.fromMap(Map<String, dynamic> map) {
    return PieChartModel(
      categoryModel: CategoryModel.fromMap(map['categoryModel']),
      amount: map['amount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PieChartModel.fromJson(String source) =>
      PieChartModel.fromMap(json.decode(source));

  PieChartModel copyWith({
    CategoryModel? categoryModel,
    int? amount,
  }) {
    return PieChartModel(
      categoryModel: categoryModel ?? this.categoryModel,
      amount: amount ?? this.amount,
    );
  }

  @override
  String toString() =>
      'PieChartModel(categoryModel: $categoryModel, amount: $amount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PieChartModel &&
        other.categoryModel == categoryModel &&
        other.amount == amount;
  }

  @override
  int get hashCode => categoryModel.hashCode ^ amount.hashCode;
}
