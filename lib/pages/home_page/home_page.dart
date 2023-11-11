import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/database/isar_service.dart';
import 'package:flutter_expense_tracker/pages/page_functions/calculate_total.dart';
import 'package:flutter_expense_tracker/pages/widgets/app_drawer.dart';
import 'package:flutter_expense_tracker/pages/home_page/entry_dialog.dart';
import 'package:flutter_expense_tracker/pages/home_page/homepage_value_tile.dart';
import 'package:flutter_expense_tracker/pages/home_page/transaction_view.dart';

const String monthFormatter = "MMMM, y";
const String dayFormatter = "MMMM d, y: EEEE";

extension DateHelper on DateTime {
  String formatMonth() {
    final formatter = DateFormat(monthFormatter);
    return formatter.format(this);
  }

  String formatDay() {
    final formatter = DateFormat(dayFormatter);
    return formatter.format(this);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<bool> bottomOpen = ValueNotifier(false);
  final currentTime = DateTime.now();
  ValueNotifier<String> titleText = ValueNotifier("This Month");

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: bottomOpen,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            bottom: () {
              if (bottomOpen.value == true) {
                return PreferredSize(
                  preferredSize: const Size.fromHeight(130),
                  child: BlocBuilder<TransactionsBloc, TransactionsState>(
                    builder: (context, state) {
                      final transactionsBloc = context.read<TransactionsBloc>();
                      if (state is TransactionsLoadedState) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  // This month
                                  DateSelectButton(
                                    transactionsBloc: transactionsBloc,
                                    bottomOpen: bottomOpen,
                                    startTime: DateTime(
                                      currentTime.year,
                                      currentTime.month,
                                      1,
                                    ),
                                    endTime: currentTime,
                                    buttonText: "This Month",
                                    titleText: titleText,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  // Last month
                                  DateSelectButton(
                                    transactionsBloc: transactionsBloc,
                                    bottomOpen: bottomOpen,
                                    startTime: DateTime(
                                      currentTime.year,
                                      currentTime.month - 1,
                                      1,
                                    ),
                                    endTime: DateTime(
                                      currentTime.year,
                                      currentTime.month,
                                      0,
                                    ),
                                    buttonText: "Last Month",
                                    titleText: titleText,
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  // Last 3 months
                                  DateSelectButton(
                                    transactionsBloc: transactionsBloc,
                                    bottomOpen: bottomOpen,
                                    startTime: DateTime(
                                      currentTime.year,
                                      currentTime.month - 2,
                                      1,
                                    ),
                                    endTime: currentTime,
                                    buttonText: "Last 3 Months",
                                    titleText: titleText,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  // Last 6 months
                                  DateSelectButton(
                                    transactionsBloc: transactionsBloc,
                                    bottomOpen: bottomOpen,
                                    startTime: DateTime(
                                      currentTime.year,
                                      currentTime.month - 5,
                                      1,
                                    ),
                                    endTime: currentTime,
                                    buttonText: "Last 6 Months",
                                    titleText: titleText,
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  // All Time
                                  DateSelectButton(
                                    transactionsBloc: transactionsBloc,
                                    bottomOpen: bottomOpen,
                                    startTime: null,
                                    endTime: null,
                                    isAllTime: true,
                                    buttonText: "All Time",
                                    titleText: titleText,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  // TODO For this make new one
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Custom',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text("No Data"),
                        );
                      }
                    },
                  ),
                );
              }
            }(),
            title: InkWell(
              onTap: () {
                // setState(() {
                bottomOpen.value = !bottomOpen.value;
                // });
              },
              child: Row(
                children: [
                  Text(
                    titleText.value,
                  ),
                  () {
                    if (bottomOpen.value == false) {
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
                transactionsList
                    ?.sort((a, b) => b.dateTime.compareTo(a.dateTime));

                // Code for sorting ascending/descending
                // snapshot.data!.sort((a, b) => a.dateTime.compareTo(b.dateTime));
                // sort date
                // snapshot.data!.sort((a, b) => b.dateTime.compareTo(a.dateTime));
                // get calculated value
                final calculatedValue =
                    calculateTotalIncomeOrExpenses(transactionsList!);
                //
                final groupByMonth = groupBy(transactionsList, (obj) {
                  final objectDateTime =
                      DateTime.parse(obj.dateTime).formatMonth();
                  return objectDateTime;
                });
                return Column(
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    HomePageValueTile(
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
                                  final calculatedMonthData =
                                      calculateTotalValue(
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
                                            color: (calculatedMonthData
                                                        .totalValue >
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
                                        DateTime.parse(obj.dateTime)
                                            .formatDay();
                                    return objectDateTime;
                                  });
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
      },
    );
  }
}

class DateSelectButton extends StatelessWidget {
  const DateSelectButton({
    Key? key,
    required this.transactionsBloc,
    required this.bottomOpen,
    required this.titleText,
    required this.startTime,
    required this.endTime,
    required this.buttonText,
    this.isAllTime,
  }) : super(key: key);

  final TransactionsBloc transactionsBloc;
  final ValueNotifier<bool> bottomOpen;
  final ValueNotifier<String> titleText;
  final DateTime? startTime;
  final DateTime? endTime;
  final String buttonText;
  final bool? isAllTime;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: () {
        if (titleText.value == buttonText) {
          return Colors.blue;
        } else {
          return Colors.transparent;
        }
      }()),
      onPressed: () {
        if (isAllTime != true || isAllTime == null) {
          transactionsBloc.add(
            TransactionsLoadedEvent(
              transactionListFromStream:
                  context.read<IsarService>().listenTransactionDateRange(
                        startTime: startTime.toString(),
                        endTime: endTime.toString(),
                      ),
            ),
          );
        } else if (isAllTime == true) {
          transactionsBloc.add(
            TransactionsLoadedEvent(
              transactionListFromStream:
                  context.read<IsarService>().listenTransactionData(),
            ),
          );
        }
        //
        bottomOpen.value = false;
        titleText.value = buttonText;
      },
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
