import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PopupTextFieldItems extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  const PopupTextFieldItems({
    Key? key,
    required this.textEditingController,
    this.keyboardType,
    this.inputFormatters,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 2),
      child: TextField(
        controller: textEditingController,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
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


