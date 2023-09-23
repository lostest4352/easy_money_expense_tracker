import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/widgets/popup_textfield_items.dart';
import 'package:flutter_expense_tracker/widgets/popup_textfield_title.dart';
import 'package:go_router/go_router.dart';
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
              return Dialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                backgroundColor: Colors.grey.shade900,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const PopupTextFieldTitle(
                      title: "Date",
                    ),
                    const PopupTextFieldItems(
                      hintText: "Today",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const PopupTextFieldTitle(
                      title: "Amount",
                    ),
                    const PopupTextFieldItems(
                      hintText: "Enter Amount",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: InkWell(
                            onTap: () {
                              context.pop();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.red.shade400,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 10),
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.blue.shade400,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const PopupTextFieldTitle(
                      title: "Category",
                    ),
                    const PopupTextFieldItems(
                      hintText: "Select Category",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const PopupTextFieldTitle(
                      title: "Note",
                    ),
                    const PopupTextFieldItems(
                      hintText: "Note(Optional)",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              );
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
