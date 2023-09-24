import 'dart:convert';

class ExpenseModel {
  int year;
  String dateTime;
  int amount;
  String category;
  bool isIncome;
  String? note;

  ExpenseModel({
    required this.year,
    required this.dateTime,
    required this.amount,
    required this.category,
    required this.isIncome,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'dateTime': dateTime,
      'amount': amount,
      'category': category,
      'isIncome': isIncome,
      'note': note,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      year: map['year']?.toInt() ?? 0,
      dateTime: map['dateTime'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
      category: map['category'] ?? '',
      isIncome: map['isIncome'] ?? false,
      note: map['note'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source));
}
