import 'package:flutter/material.dart';

class GraphsPage extends StatefulWidget {
  const GraphsPage({super.key});

  @override
  State<GraphsPage> createState() => _GraphsPageState();
}

class _GraphsPageState extends State<GraphsPage>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Income'),
    Tab(text: 'Expenses'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Graphs Page"),
        toolbarHeight: 45,
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: myTabs,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              // children: myTabs.map((Tab tab) {
              //   final String label = tab.text!.toLowerCase();
              //   return Center(
              //     child: Text(
              //       'This is the $label tab',
              //       style: const TextStyle(fontSize: 36),
              //     ),
              //   );
              // }).toList(),
              children: [
                ListView(
                  children: [
                    Center(child: Text("one")),
                  ],
                ),
                ListView(
                  children: [
                    Center(child: Text("two")),
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
