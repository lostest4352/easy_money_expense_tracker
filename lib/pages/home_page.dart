import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/pages/local_widgets/homepage_appbar.dart';
import 'package:intl/intl.dart';

import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:flutter_expense_tracker/pages/local_widgets/entry_dialog.dart';
import 'package:flutter_expense_tracker/widgets/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  int calculateMonthsData(
      DateTime date, List<TransactionModel> transactionList) {
    int monthlyAmt = 0;

    for (final transaction in transactionList) {
      final passedTransactionDate = DateTime.parse(transaction.dateTime);
      final formattedTransactionDate =
          DateFormat("MMMM, y").format(passedTransactionDate);
      //
      final formattedPassedDate = DateFormat("MMMM, y").format(date);
      //
      if (formattedTransactionDate == formattedPassedDate) {
        if (transaction.categoryModel.isIncome == true) {
          monthlyAmt += transaction.amount;
        } else {
          monthlyAmt -= transaction.amount;
        }
      }
    }
    return monthlyAmt;
  }

  @override
  Widget build(BuildContext context) {
    // Code for sorting ascending/descending
    // transactionList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    // blocTransaction.transactionList
    //     .sort((a, b) => b.dateTime.compareTo(a.dateTime));

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
              return const EntryDialog();
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
        return Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            Builder(
              builder: (context) {
                if (state is AddTransactionState) {
                  return HomePageAppBar(
                    income: blocTransaction.totalIncome,
                    expenses: blocTransaction.totalExpenses,
                  );
                } else {
                  return const HomePageAppBar(
                    income: 0,
                    expenses: 0,
                  );
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Builder(builder: (context) {
                if (state is AddTransactionState) {
                  blocTransaction.transactionList
                      .sort((a, b) => b.dateTime.compareTo(a.dateTime));
                  return ListView.builder(
                    itemCount: blocTransaction.transactionList.length,
                    itemBuilder: (context, index) {
                      bool isSameDate = true;
                      String dateString =
                          blocTransaction.transactionList[index].dateTime;
                      DateTime date = DateTime.parse(dateString);
                      if (index == 0) {
                        isSameDate = false;
                      } else {
                        String prevDateString =
                            blocTransaction.transactionList[index - 1].dateTime;
                        DateTime prevDate = DateTime.parse(prevDateString);
                        isSameDate = date.isSameDate(prevDate);
                      }
                      if (index == 0 || !isSameDate) {
                        // int monthlyInc = calculateMonthsData(date).monthlyInc;
                        // int monthlyExp = calculateMonthsData(date).monthlyExp;
                        // int calculatedData = monthlyInc + monthlyExp;
                        int calculatedData = calculateMonthsData(
                            date, blocTransaction.transactionList);
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
                            TransactionView(
                                transaction:
                                    blocTransaction.transactionList[index]),
                          ],
                        );
                      } else {
                        return TransactionView(
                            transaction:
                                blocTransaction.transactionList[index]);
                      }
                    },
                  );
                } else {
                  return Container();
                }
              }),
            ),
          ],
        );
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
          child: InkWell(
            onTap: () {},
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
        ),
      ],
    );
  }
}
