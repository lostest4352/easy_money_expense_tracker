import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/pages/functions/calculate_total.dart';
import 'package:flutter_expense_tracker/pages/widgets/homepage_appbar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/pages/widgets/entry_dialog.dart';
import 'package:flutter_expense_tracker/pages/widgets/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool bottomOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: () {
          if (bottomOpen == true) {
            return PreferredSize(
              preferredSize: const Size.fromHeight(170),
              child: Column(
                children: [
                  Text('Some Text'),
                ],
              ),
            );
          }
        }(),
        title: InkWell(
          onTap: () {
            setState(() {
              bottomOpen = !bottomOpen;
            });
          },
          child: Row(
            children: [
              const Text(
                "Expense App",
              ),
              () {
                if (bottomOpen == false) {
                  return const Icon(Icons.arrow_drop_down);
                } else {
                  return const Icon(Icons.arrow_drop_up);
                }
              }(),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.more_vert),
          // ),
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
          if (state is TransactionsLoadedState) {
            //
            final transactionsList = state.listOfTransactionData;
            transactionsList?.sort((a, b) => b.dateTime.compareTo(a.dateTime));

            // Code for sorting ascending/descending
            // snapshot.data!.sort((a, b) => a.dateTime.compareTo(b.dateTime));
            // sort date
            // snapshot.data!.sort((a, b) => b.dateTime.compareTo(a.dateTime));
            // get calculated value
            final calculatedValue =
                calculateTotalIncomeOrExpenses(transactionsList!);
            //
            final groupByMonth = groupBy(transactionsList, (obj) {
              final objectDateTime = DateTime.parse(obj.dateTime).formatMonth();
              return objectDateTime;
            });
            return Column(
              children: [
                const SizedBox(
                  height: 2,
                ),
                HomePageAppBar(
                  income: calculatedValue.totalIncome,
                  expenses: calculatedValue.totalExpense,
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
                                            (calculatedMonthData.totalValue > 0)
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
                                                padding: const EdgeInsets.only(
                                                    left: 17,
                                                    right: 17,
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
                                              // Value is TransactionModelIsar list item
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
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("No data"),
            );
          }
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
                                  "${transaction.note}",
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
