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
                      children: [
                        for (final monthEntry in groupByMonth.entries)
                          Column(
                            children: [
                              () {
                                final calculatedMonthData = calculateTotalValue(
                                  monthEntry.value,
                                );
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                  child: Column(
                                    children: [
                                      Text(
                                        // key is month name
                                        monthEntry.key,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Balance: Rs. ${calculatedMonthData.totalValue}",
                                        style: TextStyle(
                                          color:
                                              (calculatedMonthData.totalValue >
                                                      0)
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }(),
                              () {
                                final groupByDay =
                                    // Value is List<TransactionModelIsar> per month
                                    groupBy(monthEntry.value, (obj) {
                                  final objectDateTime =
                                      DateTime.parse(obj.dateTime).formatDay();
                                  return objectDateTime;
                                });
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (final dayEntry in groupByDay.entries)
                                      Column(
                                        children: [
                                          () {
                                            final calculatedDayData =
                                                calculateTotalValue(
                                              dayEntry.value,
                                            );
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 4,
                                                          bottom: 4),
                                                  child: Row(
                                                    children: [
                                                      // Key is day here
                                                      Text(dayEntry.key),
                                                      const Spacer(),
                                                      Text(
                                                        "Total: ${calculatedDayData.totalValue}",
                                                        style: TextStyle(
                                                          color: (calculatedDayData
                                                                      .totalValue >
                                                                  0)
                                                              ? Colors.green
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Value is TransactionModelIsar item
                                                for (final listItem
                                                    in dayEntry.value)
                                                  Column(
                                                    children: [
                                                      TransactionView(
                                                        transaction: listItem,
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            );
                                          }(),
                                        ],
                                      ),
                                  ],
                                );
                              }(),
                              const Divider(
                                height: 5,
                              )
                            ],
                          ),
                      ],
                    ),

                    // child: ListView(
                    //   children: groupByMonth.entries.map((entry) {
                    //     final month = entry.key;
                    //     final monthGroupedList = entry.value;

                    //     final calculatedMonthData =
                    //         calculateSelectionData(monthGroupedList);
                    //     final int monthlyIncome = calculatedMonthData.$1;
                    //     final int monthlyExpense = calculatedMonthData.$2;
                    //     final int monthlyTotal = monthlyIncome + monthlyExpense;

                    //     // Group the list by day
                    //     final groupByDay = groupBy(monthGroupedList, (obj) {
                    //       final objectDateTime =
                    //           DateTime.parse(obj.dateTime).formatDay();
                    //       return objectDateTime;
                    //     });

                    //     return Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         // ),
                    //         Align(
                    //           child: Text(month),
                    //         ),
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: groupByDay.entries.map((entry) {
                    //             final day = entry.key;
                    //             final dayGroupedlist = entry.value;
                    //             //
                    //             final calculatedDayData =
                    //                 calculateSelectionData(dayGroupedlist);
                    //             final int dailyIncome = calculatedDayData.$1;
                    //             final int dailyExpense = calculatedDayData.$2;
                    //             final int dailyTotal =
                    //                 dailyIncome + dailyExpense;
                    //             return Column(
                    //               children: [
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(
                    //                       left: 15,
                    //                       right: 15,
                    //                       top: 4,
                    //                       bottom: 4),
                    //                   child: Row(
                    //                     children: [
                    //                       Text(day),
                    //                       const Spacer(),
                    //                       Text(
                    //                         "Total: $dailyTotal",
                    //                         style: TextStyle(
                    //                           color: (dailyTotal > 0)
                    //                               ? Colors.green
                    //                               : Colors.red,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 Column(
                    //                   children: dayGroupedlist.map((listItem) {
                    //                     return TransactionView(
                    //                         transaction: listItem);
                    //                   }).toList(),
                    //                 ),
                    //                 const Divider(
                    //                   height: 4,
                    //                 ),
                    //               ],
                    //             );
                    //           }).toList(),
                    //         ),
                    //       ],
                    //     );
                    //   }).toList(),
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
const String dayFormatter = "MMMM d, y: EEEE";

extension DateHelper on DateTime {
  String formatMonth() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  String formatDay() {
    final formatter = DateFormat(dayFormatter);
    return formatter.format(this);
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
                      // Text(
                      //   DateFormat("EEEE").format(
                      //     DateTime.parse(transaction.dateTime),
                      //   ),
                      // ),
                      // const Spacer(),
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
