import 'package:flutter/material.dart';

class JobEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const JobEditor({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is missng';
        }
        return null;
      },
    );
  }
}
