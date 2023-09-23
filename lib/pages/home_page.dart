import 'package:flutter/material.dart';
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
                      for (int i = 0; i < 10; i++)
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 90,
                            height: 50,
                            color: Colors.grey.shade800,
                            padding: const EdgeInsets.all(10),
                            child: Text("tile ${i + 1}"),
                          ),
                        ),
                    ],
                  ),
                ),
                for (int i = 0; i < 10; i++)
                  ListTile(
                    title: const Text("Title"),
                    subtitle: const Text("Subtitle"),
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
