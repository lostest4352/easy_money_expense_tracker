import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:flutter_expense_tracker/global_vars/global_expense.dart';

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
    for (final expense in expenseList) {
      if (expense.isIncome == true) {
        totalIncome += expense.amount;
      } else {
        totalExpenses += expense.amount;
      }
    }

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
              //     // child: Text(
              //     //   'This is the $label tab',
              //     //   style: const TextStyle(fontSize: 36),
              //     // ),
              //     child: ListView(
              //       children: [
              //         Text(label)
              //       ],
              //     ),
              //   );
              // }).toList(),
              children: const [
                TransactionWidget(
                  isIncome: true,
                ),
                TransactionWidget(
                  isIncome: false,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionWidget extends StatelessWidget {
  final bool isIncome;
  const TransactionWidget({
    Key? key,
    required this.isIncome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 30,
              sections: [
                for (final expense in expenseList)
                  if (expense.isIncome == isIncome)
                    PieChartSectionData(
                      title: "${expense.category} ${((totalIncome / expense.amount) * 0.1).toStringAsFixed(2)}%",
                      titlePositionPercentageOffset: 1.8,
                      value: expense.amount.toDouble(),
                      color: Color(expense.colorsValue),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
