import 'package:flutter/material.dart';

class CustomTestField extends StatelessWidget {
  const CustomTestField(
      {super.key,
      required this.submitBtnEnable,
      required this.labelText,
      required this.hintText,
      required this.maxLength,
      required this.textInputType,
      required this.textEditingController,
      required this.onChange,
      required this.prefixIcon});

  final bool submitBtnEnable;
  final IconData prefixIcon;
  final String labelText;
  final String hintText;
  final int maxLength;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final void Function(String text) onChange;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        onChanged: (text) {
          onChange.call(text);
        },
        controller: textEditingController,
        keyboardType: textInputType,
        maxLength: maxLength,
        decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            border: const OutlineInputBorder(),
            labelText: labelText,
            hintText: hintText),
      ),
    );
  }
}
