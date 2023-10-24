import 'package:isar/isar.dart';

part 'isar_classes.g.dart';

@collection
class TransactionModelIsar {
  Id id = Isar.autoIncrement;
  late String dateTime;
  late int amount;
  String? note;

  IsarLink<CategoryModelIsar> categoryModelIsar = IsarLink<CategoryModelIsar>();
}

@collection
class CategoryModelIsar {
  Id id = Isar.autoIncrement;
  late String transactionType;
  late bool isIncome;
  late int colorsValue;
}
