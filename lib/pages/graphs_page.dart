import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/global_vars/global_expense.dart';
import 'package:flutter_expense_tracker/models/pie_chart_model.dart';

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
    _tabController = TabController(
      vsync: this,
      length: myTabs.length,
    );
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
              children: [
                TransactionWidget(
                  isIncome: true,
                  totalValue: totalIncome,
                ),
                TransactionWidget(
                  isIncome: false,
                  totalValue: totalExpenses,
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

  final int totalValue;
  const TransactionWidget({
    Key? key,
    required this.isIncome,
    required this.totalValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final seen = <CategoryModel>{};
    // List<CategoryModel> filteredTransaction = listItems.where(
    //   (transactionModel) {
    //     var val = seen.add(transactionModel.transactionType);
    //     return val;
    //   },
    // ).toList();

    List<PieChartModel> pieChartModelList = [];

    for (final transaction in transactionList) {
      bool found = false;
      for (final pieChartModel in pieChartModelList) {
        if (pieChartModel.categoryModel == transaction.categoryModel) {
          found = true;
          pieChartModel.amount += transaction.amount;
        }
      }

      if (!found) {
        pieChartModelList.add(
          PieChartModel(
            categoryModel: transaction.categoryModel,
            amount: transaction.amount,
          ),
        );
      }
    }

    return ListView(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              // sectionsSpace: 0,
              centerSpaceRadius: 50,
              sections: [
                for (final pieChartTransaction in pieChartModelList)
                  if (pieChartTransaction.categoryModel.isIncome == isIncome)
                    PieChartSectionData(
                      title:
                          "${pieChartTransaction.categoryModel.transactionType} ${((pieChartTransaction.amount / totalValue) * 100).toStringAsFixed(2)}%",
                      titlePositionPercentageOffset: 1.8,
                      value: pieChartTransaction.amount.toDouble(),
                      color:
                          Color(pieChartTransaction.categoryModel.colorsValue),
                    ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            for (final pieChartTransaction in pieChartModelList)
              if (pieChartTransaction.categoryModel.isIncome == isIncome)
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(pieChartTransaction.categoryModel.transactionType),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          color: Color(
                              pieChartTransaction.categoryModel.colorsValue),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            const Divider(),
            ListTile(
              title: const Text("Total"),
              trailing: Text("$totalValue"),
            ),
            const Divider(),
            for (final pieChartTransaction in pieChartModelList)
              if (pieChartTransaction.categoryModel.isIncome == isIncome)
                ListTile(
                  title:
                      Text(pieChartTransaction.categoryModel.transactionType),
                  trailing: Text(
                    pieChartTransaction.amount.toString(),
                  ),
                ),
          ],
        ),
      ],
    );
  }
}
