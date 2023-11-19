import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/blocs/search_cubit/search_cubit.dart';
import 'package:flutter_expense_tracker/database/isar_service.dart';
import 'package:flutter_expense_tracker/pages/home_page/transaction_view.dart';
import 'package:flutter_expense_tracker/pages/widgets/popup_textfield_items.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SearchCubit(
          isarService: context.read<IsarService>(),
        );
      },
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Expanded(
                    child: PopupTextFieldItems(
                      textEditingController: textEditingController,
                      hintText: "Search",
                      suffixIcon: IconButton(
                        onPressed: () {
                          return context
                              .read<SearchCubit>()
                              .searchClicked(textEditingController.text);
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoadedState) {
                  final transactionsList = state.listOfTransactionData;
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: transactionsList?.length,
                          itemBuilder: (context, index) {
                            if (transactionsList != null) {
                              return TransactionView(
                                transaction: transactionsList[index],
                              );
                            } else {
                              return const Center(
                                child: Text("No Data"),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("Not searched yet"),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
