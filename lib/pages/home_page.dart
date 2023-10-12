import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
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
  // TODO bloc
  // void changeData(TransactionModel transactionModel, bool isIncome) {
  //   setState(() {
  //     transactionList.add(transactionModel);
  //     if (isIncome == true) {
  //       totalIncome += transactionModel.amount;
  //     } else {
  //       totalExpenses += transactionModel.amount;
  //     }
  //   });
  // }

  // TransactionsBloc get blocTransaction => context.read<TransactionsBloc>();

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
        return Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            Builder(
              builder: (context) {
                if (state is AddTransactionState) {
                  // test
                  return Container(
                    width: double.infinity,
                    color: const Color(0x33BDE9FF),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Text("Income: Rs.${state.totalIncome}"),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Text("Expenses: Rs.${state.totalExpenses}"),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                                "Balance: Rs.${state.totalIncome - state.totalExpenses}"),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    width: double.infinity,
                    color: const Color(0x33BDE9FF),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text("Income: Rs. 0"),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text("Expenses: Rs. 0"),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text("Balance: Rs. 0"),
                          ),
                        ],
                      ),
                    ),
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
                  state.transactionList
                      .sort((a, b) => b.dateTime.compareTo(a.dateTime));
                  return ListView.builder(
                    itemCount: state.transactionList.length,
                    itemBuilder: (context, index) {
                      bool isSameDate = true;
                      String dateString = state.transactionList[index].dateTime;
                      DateTime date = DateTime.parse(dateString);
                      if (index == 0) {
                        isSameDate = false;
                      } else {
                        String prevDateString =
                            state.transactionList[index - 1].dateTime;
                        DateTime prevDate = DateTime.parse(prevDateString);
                        isSameDate = date.isSameDate(prevDate);
                      }
                      if (index == 0 || !isSameDate) {
                        // int monthlyInc = calculateMonthsData(date).monthlyInc;
                        // int monthlyExp = calculateMonthsData(date).monthlyExp;
                        // int calculatedData = monthlyInc + monthlyExp;
                        int calculatedData = state.calculateMonthsData(date);
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
                                transaction: state.transactionList[index]),
                          ],
                        );
                      } else {
                        return TransactionView(
                            transaction: state.transactionList[index]);
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
