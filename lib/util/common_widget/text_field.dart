import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  const InputTextField(
      {super.key,
      required this.prefix,
      required this.hintText,
      required this.isMobileNumber,
      required this.isPassword,
      required this.keyboardType,
      required this.textEditingController});

  final IconData prefix;
  final String hintText;
  final bool isMobileNumber;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController textEditingController;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(widget.prefix),
          const SizedBox(
            width: 10,
          ),
          //isMobileNumber == true ? const Text("+91 ") : const SizedBox(),
          Expanded(
            child: TextField(
              controller: widget.textEditingController,
              keyboardType: widget.keyboardType,
              obscureText: widget.isPassword && !isPasswordVisible,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
              ),
            ),
          ),
          widget.isPassword == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(isPasswordVisible == true
                      ? Icons.visibility
                      : Icons.visibility_off))
              : const SizedBox()
        ],
      ),
    );
  }
}
