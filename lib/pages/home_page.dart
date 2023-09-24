// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/expense_model.dart';
import 'package:flutter_expense_tracker/pages/dialogs/entry_dialog.dart';
import 'package:flutter_expense_tracker/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    int totalExpenses = 0;
    int totalIncome = 0;

    List<ExpenseModel> expenseList = [
      ExpenseModel(
        year: 2023,
        dateTime: "September 24, Sunday",
        amount: 6000,
        category: "Salary",
        isIncome: true,
      ),
      ExpenseModel(
        year: 2023,
        dateTime: "September 24, Sunday",
        amount: 5000,
        category: "Food",
        isIncome: false,
      ),
      ExpenseModel(
        year: 2023,
        dateTime: "September 24, Sunday",
        amount: 7000,
        category: "Wages",
        isIncome: true,
      ),
      ExpenseModel(
          year: 2023,
          dateTime: "September 24, Sunday",
          amount: 2000,
          category: "Clothing",
          isIncome: false,
          note: "Bought a t-shirt"),
    ];

    for (final expense in expenseList) {
      if (expense.isIncome == true) {
        totalIncome += expense.amount;
      } else {
        totalExpenses += expense.amount;
      }
    }

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
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding: EdgeInsets.all(8),
        label: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0, top: 12, bottom: 12),
              child: Icon(Icons.add),
            ),
            Text(
              "Add Item",
            ),
          ],
        ),
        backgroundColor: Colors.blueAccent.shade400,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const EntryDialog();
            },
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
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
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text("December 55"),
                ),
                SizedBox(
                  height: 10,
                ),
                for (final expense in expenseList)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "${expense.year}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          Text(" "),
                          Text(expense.dateTime),
                          Spacer(),
                          Text(
                            "${expense.amount}",
                            style: TextStyle(
                                color: (expense.isIncome == true)
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
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
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: (expense.isIncome == true)
                                        ? Colors.green
                                        : null,
                                    maxRadius: 12,
                                    child: (expense.isIncome == true)
                                        ? Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          )
                                        : Icon(Icons.remove),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        expense.category,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      (expense.note != null)
                                          ? Column(
                                              children: [
                                                Text(
                                                  "${expense.note}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            )
                                          : Column(),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    "${expense.amount}",
                                    style: TextStyle(
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
