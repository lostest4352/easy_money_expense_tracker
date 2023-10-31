import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/database/isar_service.dart';
import 'package:flutter_expense_tracker/pages/functions/calculate_total.dart';
import 'package:flutter_expense_tracker/pages/widgets/homepage_appbar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/pages/widgets/entry_dialog.dart';
import 'package:flutter_expense_tracker/pages/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<List<TransactionModelIsar>> listenTransactionData =
        context.read<IsarService>().listenTransactionData();
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
              return const EntryDialog(editMode: false);
            },
          );
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (context, state) {
          //
          return StreamBuilder(
            stream: listenTransactionData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center();
              }
              // Code for sorting ascending/descending
              // snapshot.data!.sort((a, b) => a.dateTime.compareTo(b.dateTime));
              // sort date
              snapshot.data!.sort((a, b) => b.dateTime.compareTo(a.dateTime));
              // get calculated value
              final calculatedValue = calculateTotalIncomeOrExpenses(snapshot);
              //
              final groupByMonth = groupBy(snapshot.data!, (obj) {
                final objectDateTime =
                    DateTime.parse(obj.dateTime).formatMonth();
                return objectDateTime;
              });
              return Column(
                children: [
                  const SizedBox(
                    height: 2,
                  ),
                  HomePageAppBar(
                    income: calculatedValue.$1,
                    expenses: calculatedValue.$2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: ListView(
                      children: groupByMonth.entries.map((entry) {
                        final month = entry.key;
                        final monthGroupedList = entry.value;
                        final groupByDay = groupBy(monthGroupedList, (obj) {
                          final objectDateTime =
                              DateTime.parse(obj.dateTime).formatDay();
                          return objectDateTime;
                        });

                        final calculatedMonthData =
                            calculateSelectionData(monthGroupedList);
                        final int monthlyIncome = calculatedMonthData.$1;
                        final int monthlyExpense = calculatedMonthData.$2;
                        final int monthlyTotal = monthlyIncome + monthlyExpense;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   '$month: Income: ${calculatedMonthData.$1}, Expenses: ${calculatedMonthData.$2}',
                            // ),
                            Align(
                              child: Text(month),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: groupByDay.entries.map((entry) {
                                final day = entry.key;
                                final dayGroupedlist = entry.value;
                                //
                                final calculatedDayData =
                                    calculateSelectionData(dayGroupedlist);
                                final int dailyIncome = calculatedDayData.$1;
                                final int dailyExpense = calculatedDayData.$2;
                                final int dailyTotal =
                                    dailyIncome + dailyExpense;
                                return Column(
                                  children: [
                                    // Text(
                                    //   '$day: Income: ${calculatedDayData.$1}, Expenses: ${calculatedDayData.$2}',
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 4,
                                          bottom: 4),
                                      child: Row(
                                        children: [
                                          Text(day),
                                          const Spacer(),
                                          Text(
                                            "Total: $dailyTotal",
                                            style: TextStyle(
                                              color: (dailyTotal > 0)
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: dayGroupedlist.map((listItem) {
                                        // return Text(
                                        //     '${listItem.transactionType}, ${listItem.amount}');

                                        return TransactionView(
                                            transaction: listItem);
                                      }).toList(),
                                    ),
                                    const Divider(
                                      height: 1,
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      }).toList(),
                    ),

                    // child: CustomScrollView(
                    //   slivers: [
                    //     SliverList.builder(
                    //       itemCount: snapshot.data?.length,
                    //       itemBuilder: (context, index) {
                    //         bool isSameDate = true;
                    //         String dateString = snapshot.data![index].dateTime;
                    //         DateTime date = DateTime.parse(dateString);
                    //         if (index == 0) {
                    //           isSameDate = false;
                    //         } else {
                    //           String prevDateString =
                    //               snapshot.data![index - 1].dateTime;
                    //           DateTime prevDate =
                    //               DateTime.parse(prevDateString);
                    //           isSameDate = date.isSameDate(prevDate);
                    //         }
                    //         if (index == 0 || !isSameDate) {
                    //           // if income and expenses seperated for each month later
                    //           // int monthlyInc = calculateMonthsData(date).monthlyInc;
                    //           // int monthlyExp = calculateMonthsData(date).monthlyExp;
                    //           // int calculatedData = monthlyInc + monthlyExp;
                    //           int calculatedData =
                    //               calculateMonthsData(date, snapshot.data!);
                    //           return Column(
                    //             children: [
                    //               Padding(
                    //                 padding: const EdgeInsets.only(
                    //                     left: 15, right: 15, top: 4, bottom: 4),
                    //                 child: Row(
                    //                   children: [
                    //                     Text(date.formatDate()),
                    //                     const Spacer(),
                    //                     Text(
                    //                       "Total: $calculatedData",
                    //                       style: TextStyle(
                    //                         color: (calculatedData > 0)
                    //                             ? Colors.green
                    //                             : Colors.red,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //               TransactionView(
                    //                 transaction: snapshot.data![index],
                    //               ),
                    //             ],
                    //           );
                    //         } else {
                    //           return TransactionView(
                    //             transaction: snapshot.data![index],
                    //           );
                    //         }
                    //       },
                    //     ),
                    //   ],
                    // ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// extension method from SO
const String dateFormatter = "MMMM, y";
const String dayFormatter = "d MMMM, y";

extension DateHelper on DateTime {
  String formatMonth() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  String formatDay() {
    final formatter = DateFormat(dayFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        // &&  day == other.day
        ;
  }

  // bool isSameDay(DateTime other) {
  //   return year == other.year && month == other.month
  //       &&  day == other.day
  //       ;
  // }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}

//
class TransactionView extends StatelessWidget {
  final TransactionModelIsar transaction;
  const TransactionView({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return EntryDialog(
                    editMode: true,
                    transaction: transaction,
                  );
                },
              );
            },
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
                        backgroundColor: (transaction.isIncome == true)
                            ? Colors.green
                            : Colors.red,
                        maxRadius: 12,
                        child: (transaction.isIncome == true)
                            ? const Icon(
                                Icons.add,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.transactionType,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        DateFormat("MMM dd, EE").format(
                          DateTime.parse(transaction.dateTime),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 120),
                        child: Text(
                          "${transaction.amount}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: (transaction.isIncome == true)
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: () {
                        if (transaction.note != null) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              children: [
                                Text(
                                  "Note: ${transaction.note}",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
