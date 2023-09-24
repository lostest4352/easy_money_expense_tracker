// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/pages/dialogs/entry_dialog.dart';
import 'package:flutter_expense_tracker/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final expenses = 500;
  final income = 800;

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
                          child: Text("Income: Rs.$income"),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          color: Colors.grey.shade800,
                          padding: const EdgeInsets.all(10),
                          child: Text("Expenses: Rs.$expenses"),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          color: Colors.grey.shade800,
                          padding: const EdgeInsets.all(10),
                          child: Text("Balance: Rs.${income - expenses}"),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(child: Text("December 55")),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "2023  ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        Text("Dec 55, Sat"),
                        Spacer(),
                        Text(
                          "Rs. 85",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
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
                        child: Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 12,
                              child: Icon(Icons.remove),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Fuel",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              "Rs. 85",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
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
