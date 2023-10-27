// import 'dart:convert';

// import 'package:flutter/widgets.dart';

// import 'package:flutter_expense_tracker/models/category_model.dart';

// class TransactionModel {
//   String dateTime;
//   int amount;
//   String? note;
//   CategoryModel categoryModel;

//   TransactionModel({
//     required this.dateTime,
//     required this.amount,
//     this.note,
//     required this.categoryModel,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'dateTime': dateTime,
//       'amount': amount,
//       'note': note,
//       'categoryModel': categoryModel.toMap(),
//     };
//   }

//   factory TransactionModel.fromMap(Map<String, dynamic> map) {
//     return TransactionModel(
//       dateTime: map['dateTime'] ?? '',
//       amount: map['amount']?.toInt() ?? 0,
//       note: map['note'],
//       categoryModel: CategoryModel.fromMap(map['categoryModel']),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory TransactionModel.fromJson(String source) =>
//       TransactionModel.fromMap(json.decode(source));

//   TransactionModel copyWith({
//     String? dateTime,
//     int? amount,
//     ValueGetter<String?>? note,
//     CategoryModel? categoryModel,
//   }) {
//     return TransactionModel(
//       dateTime: dateTime ?? this.dateTime,
//       amount: amount ?? this.amount,
//       note: note != null ? note() : this.note,
//       categoryModel: categoryModel ?? this.categoryModel,
//     );
//   }

//   @override
//   String toString() {
//     return 'TransactionModel(dateTime: $dateTime, amount: $amount, note: $note, categoryModel: $categoryModel)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
  
//     return other is TransactionModel &&
//       other.dateTime == dateTime &&
//       other.amount == amount &&
//       other.note == note &&
//       other.categoryModel == categoryModel;
//   }

//   @override
//   int get hashCode {
//     return dateTime.hashCode ^
//       amount.hashCode ^
//       note.hashCode ^
//       categoryModel.hashCode;
//   }
// }
