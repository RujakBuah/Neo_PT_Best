import 'package:flutter/material.dart';

class JobEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String input;
  const JobEditor({
    super.key,
    required this.controller,
    required this.hintText,
    required this.input,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if (value!.isEmpty) {
          return '$input is missng';
        }
        return null;
      },
    );
  }
}
