import 'package:isar/isar.dart';

part 'isar_classes.g.dart';

@Collection()
class TransactionModelIsar {
  Id id = Isar.autoIncrement;
  late String dateTime;
  late int amount;
  String? note;

  //
  late String transactionType;
  late bool isIncome;
  late int colorsValue;
}

@Collection()
class CategoryModelIsar {
  Id id = Isar.autoIncrement;
  late String transactionType;
  late bool isIncome;
  late int colorsValue;
}
