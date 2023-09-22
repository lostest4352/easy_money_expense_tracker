// TODO Remove this later
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final val = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 400,
                child: Card(
                  color: Colors.black12,
                  child: Text("efeefe"),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: (val == 5)
          ? null
          : BottomNavigationBar(
              backgroundColor: Colors.black12,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_outlined),
                  label: 'Transactions',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.incomplete_circle_outlined),
                  label: 'Graphs',
                ),
              ],
            ),
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
                      for (int i = 0; i < 10; i++)
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 90,
                            height: 50,
                            color: Colors.black12,
                            padding: const EdgeInsets.all(10),
                            child: Text("tile ${i + 1}"),
                          ),
                        ),
                    ],
                  ),
                ),
                for (int i = 0; i < 10; i++)
                  ListTile(
                    title: Text("Title"),
                    subtitle: Text("Subtitle"),
                    leading: CircleAvatar(
                      child: Text(
                        (i + 1).toString(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
