import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
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
        TransactionsBloc blocTransaction = context.read<TransactionsBloc>();
        Stream<List<TransactionModelIsar>> listenTransactionData =
            blocTransaction.isarService.listenTransactionData();
        //
        return StreamBuilder(
            stream: listenTransactionData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center();
              }
              return Column(
                children: [
                  const SizedBox(
                    height: 2,
                  ),
                  Builder(
                    builder: (context) {
                      final value = calculateTotalIncomeOrExpenses(snapshot);
                      return HomePageAppBar(
                        income: value.$1,
                        expenses: value.$2,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Builder(builder: (context) {
                      // Code for sorting ascending/descending
                      // blocTransactionList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
                      // blocTransaction.transactionList
                      //     .sort((a, b) => b.dateTime.compareTo(a.dateTime));
                      snapshot.data!
                          .sort((a, b) => b.dateTime.compareTo(a.dateTime));
                      return CustomScrollView(
                        slivers: [
                          SliverList.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              bool isSameDate = true;
                              String dateString =
                                  snapshot.data![index].dateTime;
                              DateTime date = DateTime.parse(dateString);
                              if (index == 0) {
                                isSameDate = false;
                              } else {
                                String prevDateString =
                                    snapshot.data![index - 1].dateTime;
                                DateTime prevDate =
                                    DateTime.parse(prevDateString);
                                isSameDate = date.isSameDate(prevDate);
                              }
                              if (index == 0 || !isSameDate) {
                                // if income and expenses seperated for each month later
                                // int monthlyInc = calculateMonthsData(date).monthlyInc;
                                // int monthlyExp = calculateMonthsData(date).monthlyExp;
                                // int calculatedData = monthlyInc + monthlyExp;
                                int calculatedData =
                                    calculateMonthsData(date, snapshot.data!);

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 4,
                                          bottom: 4),
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
                                    TransactionView(
                                      transaction: snapshot.data![index],
                                    ),
                                  ],
                                );
                              } else {
                                return TransactionView(
                                  transaction: snapshot.data![index],
                                );
                              }
                            },
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              );
            });
      }),
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
