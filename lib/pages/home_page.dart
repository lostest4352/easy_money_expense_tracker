import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/global_vars/global_expense.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:flutter_expense_tracker/pages/dialogs_widgets/entry_dialog.dart';
import 'package:flutter_expense_tracker/widgets/app_drawer.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO
  void changeData(TransactionModel transactionModel, bool isIncome) {
    setState(() {
      transactionList.add(transactionModel);
      for (final item in listItems) {
        if (item.transactionType == transactionModel.category) {
          item.transactionAmount += transactionModel.amount;
        }
      }
      if (isIncome == true) {
        totalIncome += transactionModel.amount;
      } else {
        totalExpenses += transactionModel.amount;
      }
    });
  }

  //
  DateTime selectedDate = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd');
  String get formattedDate => formatter.format(selectedDate);
  //
  final currentDayFormatted =
      DateFormat('MMMM dd, EEEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    // Code for sorting ascending/descending
    // transactionList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    transactionList.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expense App",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return EntryDialog(
                changeData: changeData,
              );
            },
          );
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          const SizedBox(
            height: 2,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.grey.shade800,
                    padding: const EdgeInsets.all(10),
                    child: Text("Income: Rs.$totalIncome"),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.grey.shade800,
                    padding: const EdgeInsets.all(10),
                    child: Text("Expenses: Rs.$totalExpenses"),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.grey.shade800,
                    padding: const EdgeInsets.all(10),
                    child: Text("Balance: Rs.${totalIncome - totalExpenses}"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: ListView(
              children: [
                for (final (index, transaction) in transactionList.indexed)
                  Builder(
                    builder: (context) {
                      bool isSameDate = true;
                      String dateString = transactionList[index].dateTime;
                      DateTime date = DateTime.parse(dateString);

                      //
                      if (index == 0) {
                        isSameDate = false;
                      } else {
                        String prevDateString =
                            transactionList[index - 1].dateTime;
                        DateTime prevDate = DateTime.parse(prevDateString);
                        isSameDate = date.isSameDate(prevDate);
                      }
                      if (index == 0 || !isSameDate) {
                        return Column(
                          children: [
                            Text(date.formatDate()),
                            TransactionView(transaction: transaction),
                          ],
                        );
                      } else {
                        return TransactionView(transaction: transaction);
                      }
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionView extends StatelessWidget {
  const TransactionView({
    super.key,
    required this.transaction,
  });

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(120, 33, 149, 243),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          (transaction.isIncome == true) ? Colors.green : null,
                      maxRadius: 12,
                      child: (transaction.isIncome == true)
                          ? const Icon(
                              Icons.add,
                              color: Colors.white,
                            )
                          : const Icon(Icons.remove),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.category,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        (transaction.note != null)
                            ? Column(
                                children: [
                                  Text(
                                    "${transaction.note}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            : const Column(),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      DateFormat('yyyy MMMM dd').format(
                        DateTime.parse(transaction.dateTime),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${transaction.amount}",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: (transaction.isIncome == true)
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// extension method from SO
const String dateFormatter = 'MMMM, y';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        // &&  day == other.day
        ;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
