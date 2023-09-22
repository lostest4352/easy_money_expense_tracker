// TODO Remove this later
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        // TODO Remove later
        width: 260,
        child: ListView(
          children: [
            DrawerHeader(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    'Million dollars',
                    style: GoogleFonts.roboto(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Text(
                    "Expense tracker",
                    style: GoogleFonts.roboto(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet_outlined),
              title: Text(
                'Transactions',
                style: GoogleFonts.roboto(),
              ),
            ),
            ListTile(
              leading: Icon(Icons.label),
              title: Text(
                'Categories',
                style: GoogleFonts.roboto(),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: GoogleFonts.roboto(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black12,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle_outlined), label: ''),
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
