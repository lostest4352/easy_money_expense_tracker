import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/pages/widgets/popup_textfield_items.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: PopupTextFieldItems(
                textEditingController: textEditingController,
                hintText: "Search",
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
