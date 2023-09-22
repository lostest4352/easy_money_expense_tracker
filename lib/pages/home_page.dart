import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense App"),
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      drawer: const Drawer(),
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
