import 'dart:convert';

class TransactionModel {
  int year;
  String dateTime;
  int amount;
  String category;
  bool isIncome;
  int colorsValue;
  String? note;

  TransactionModel({
    required this.year,
    required this.dateTime,
    required this.amount,
    required this.category,
    required this.isIncome,
    required this.colorsValue,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'dateTime': dateTime,
      'amount': amount,
      'category': category,
      'isIncome': isIncome,
      'colorsValue': colorsValue,
      'note': note,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      year: map['year']?.toInt() ?? 0,
      dateTime: map['dateTime'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
      category: map['category'] ?? '',
      isIncome: map['isIncome'] ?? false,
      colorsValue: map['colorsValue']?.toInt() ?? 0,
      note: map['note'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));
}
