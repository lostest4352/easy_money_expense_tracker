import 'dart:convert';

class CategoryModel {
  String transactionType;
  bool isIncome;
  int colorsValue;
  num transactionAmount;
  CategoryModel({
    required this.transactionType,
    required this.isIncome,
    required this.colorsValue,
    this.transactionAmount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'transactionType': transactionType,
      'isIncome': isIncome,
      'colorsValue': colorsValue,
      'transactionAmount': transactionAmount,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      transactionType: map['transactionType'] ?? '',
      isIncome: map['isIncome'] ?? false,
      colorsValue: map['colorsValue']?.toInt() ?? 0,
      transactionAmount: map['transactionAmount'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));
}
