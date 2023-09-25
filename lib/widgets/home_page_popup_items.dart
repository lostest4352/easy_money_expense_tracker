import 'package:flutter/material.dart';

class PopupTextFieldItems extends StatelessWidget {
  final String hintText;
  const PopupTextFieldItems({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 2),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
          contentPadding: const EdgeInsets.all(12),
          filled: true,
          fillColor: Colors.grey.shade800,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(55),
          ),
        ),
      ),
    );
  }
}

class PopupTextFieldTitle extends StatelessWidget {
  final String title;
  const PopupTextFieldTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.blue.shade400,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class PopupCategoryItems extends StatelessWidget {
  final String title;
  const PopupCategoryItems({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          height: 35,
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(55),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(title),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
