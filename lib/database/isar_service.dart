import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarInstance {
  Isar? isarValue;

  void getIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [TransactionModelIsarSchema],
      directory: dir.path,
    );
    isarValue = isar;
  }
}
