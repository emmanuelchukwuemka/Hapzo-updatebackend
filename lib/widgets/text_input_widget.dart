import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final Icon icon;
  final TextEditingController controller;
  final bool isObscure;

  const InputField({super.key, required this.labelText, required this.icon, required this.controller, this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          icon: icon,
        ),
      ),
    );
  }
}
