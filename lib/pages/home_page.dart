import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/global_vars/global_expense.dart';
import 'package:flutter_expense_tracker/pages/dialogs/entry_dialog.dart';
import 'package:flutter_expense_tracker/widgets/app_drawer.dart';

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
              return const EntryDialog();
            },
          );
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
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
                          child: Text(
                              "Balance: Rs.${totalIncome - totalExpenses}"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text("December 55"),
                ),
                const SizedBox(
                  height: 10,
                ),
                for (final transaction in transactionList)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "${transaction.year}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          const Text(" "),
                          Text(transaction.dateTime),
                          const Spacer(),
                          Text(
                            "${transaction.amount}",
                            style: TextStyle(
                                color: (transaction.isIncome == true)
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
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
                                        (transaction.isIncome == true)
                                            ? Colors.green
                                            : null,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transaction.category,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      (transaction.note != null)
                                          ? Column(
                                              children: [
                                                Text(
                                                  "${transaction.note}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            )
                                          : const Column(),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    "${transaction.amount}",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
