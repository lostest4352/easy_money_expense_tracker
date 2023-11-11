import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_expense_tracker/blocs/time_range_cubit/time_range_cubit.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/pages/home_page/entry_dialog.dart';
import 'package:flutter_expense_tracker/pages/home_page/homepage_value_tile.dart';
import 'package:flutter_expense_tracker/pages/home_page/transaction_view.dart';
import 'package:flutter_expense_tracker/pages/page_functions/calculate_total.dart';
import 'package:flutter_expense_tracker/pages/widgets/app_drawer.dart';

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
  String get titleText => context.read<TimeRangeCubit>().state.buttonName;

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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const Spacer(),
                            // This month
                            DateSelectButton(
                              bottomOpen: bottomOpen,
                              buttonText: "This Month",
                              titleText: titleText,
                              timeRangeState: TimeRangeState(
                                buttonName: "This Month",
                                startTime: DateTime(
                                  currentTime.year,
                                  currentTime.month,
                                  1,
                                ).toString(),
                                endTime: currentTime.toString(),
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            // Last month
                            DateSelectButton(
                              bottomOpen: bottomOpen,
                              buttonText: "Last Month",
                              titleText: titleText,
                              timeRangeState: TimeRangeState(
                                buttonName: "Last Month",
                                startTime: DateTime(
                                  currentTime.year,
                                  currentTime.month - 1,
                                  1,
                                ).toString(),
                                endTime: DateTime(
                                  currentTime.year,
                                  currentTime.month,
                                  0,
                                ).toString(),
                              ),
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
                              bottomOpen: bottomOpen,
                              buttonText: "Last 3 Months",
                              titleText: titleText,
                              timeRangeState: TimeRangeState(
                                buttonName: "Last 3 Months",
                                startTime: DateTime(
                                  currentTime.year,
                                  currentTime.month - 2,
                                  1,
                                ).toString(),
                                endTime: currentTime.toString(),
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            // Last 6 months
                            DateSelectButton(
                              bottomOpen: bottomOpen,
                              buttonText: "Last 6 Months",
                              titleText: titleText,
                              timeRangeState: TimeRangeState(
                                buttonName: "Last 6 Months",
                                startTime: DateTime(
                                  currentTime.year,
                                  currentTime.month - 5,
                                  1,
                                ).toString(),
                                endTime: currentTime.toString(),
                              ),
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
                              bottomOpen: bottomOpen,
                              buttonText: "All Time",
                              titleText: titleText,
                              timeRangeState:
                                  const TimeRangeState(buttonName: "All Time"),
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
                  ),
                );
              }
            }(),
            title: InkWell(
              onTap: () {
                bottomOpen.value = !bottomOpen.value;
              },
              child: Row(
                children: [
                  Text(
                    titleText,
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
    required this.bottomOpen,
    required this.titleText,
    required this.buttonText,
    required this.timeRangeState,
  }) : super(key: key);

  final ValueNotifier<bool> bottomOpen;
  final String titleText;
  final String buttonText;
  final TimeRangeState timeRangeState;

  @override
  Widget build(BuildContext context) {
    final transactionsBloc = context.read<TransactionsBloc>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: () {
        if (titleText == buttonText) {
          return Colors.blue;
        } else {
          return Colors.transparent;
        }
      }()),
      onPressed: () {
        //
        transactionsBloc.add(
          TransactionsLoadedEvent(timeRangeState: timeRangeState),
        );
        //
        bottomOpen.value = false;
        // save new state
        context.read<TimeRangeCubit>().timeRangeState(timeRangeState.startTime,
            timeRangeState.endTime, timeRangeState.buttonName);
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
