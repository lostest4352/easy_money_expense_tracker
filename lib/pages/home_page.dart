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
      if (isIncome == true) {
        totalIncome += transactionModel.amount;
      } else {
        totalExpenses += transactionModel.amount;
      }
    });
  }

  // TODO temp
  List<DateTime> datetimeList = [];

  void getAllDateOnly() {
    for (final trns in transactionList) {
      datetimeList.add(DateTime.parse(trns.dateTime));
    }
  }

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
          Container(
            width: double.infinity,
            color: const Color(0x33BDE9FF),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text("Income: Rs.$totalIncome"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text("Expenses: Rs.$totalExpenses"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text("Balance: Rs.${totalIncome - totalExpenses}"),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: Builder(
              builder: (context) {
                transactionList = transactionList.where((transaction) {
                  // TODO temp
                  // final dtt = DateTime.parse(transaction.dateTime);
                  // final dttformat = DateTime(dtt.year, dtt.month);
                  // final nowdate = DateTime.now();
                  // final nowdatef = DateTime(nowdate.year, nowdate.month -1);
                  // return dttformat == nowdatef;

                  DateTimeRange firstdate = DateTimeRange(start: DateTime.parse("2023-08-01 21:29:37.782992"), end: DateTime.now(),);
                  if (DateTime.parse(transaction.dateTime).isAfter(firstdate.start) && DateTime.parse(transaction.dateTime).isBefore(firstdate.end)) {
                    return true;
                  } else {
                    return false;
                  }

                }).toList();
                return ListView.builder(
                  itemCount: transactionList.length,
                  itemBuilder: (context, index) {
                    bool isSameDate = true;
                    String dateString = transactionList[index].dateTime;
                    DateTime date = DateTime.parse(dateString);
                    if (index == 0) {
                      isSameDate = false;
                    } else {
                      String prevDateString = transactionList[index - 1].dateTime;
                      DateTime prevDate = DateTime.parse(prevDateString);
                      isSameDate = date.isSameDate(prevDate);
                    }
                    if (!isSameDate) {
                      // int monthlyInc = calculateMonthsData(date).monthlyInc;
                      // int monthlyExp = calculateMonthsData(date).monthlyExp;
                      // int calculatedData = monthlyInc + monthlyExp;
                      int calculatedData = calculateMonthsData(date);
                      debugPrint("This is date: ${date.toString()}");
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 4, bottom: 4),
                            child: Row(
                              children: [
                                Text(date.formatDate()),
                                const Spacer(),
                                Text(
                                  "Total: $calculatedData",
                                  style: TextStyle(
                                    color: (calculatedData > 0)
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TransactionView(transaction: transactionList[index]),
                        ],
                      );
                    } else {
                      return TransactionView(transaction: transactionList[index]);
                    }
                  },
                );
              }
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
          padding: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
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
                          (transaction.categoryModel.isIncome == true)
                              ? Colors.green
                              : null,
                      maxRadius: 12,
                      child: (transaction.categoryModel.isIncome == true)
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
                          transaction.categoryModel.transactionType,
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
                      DateFormat("MMM dd, EE").format(
                        DateTime.parse(transaction.dateTime),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${transaction.amount}",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: (transaction.categoryModel.isIncome == true)
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
const String dateFormatter = "MMMM, y";

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
