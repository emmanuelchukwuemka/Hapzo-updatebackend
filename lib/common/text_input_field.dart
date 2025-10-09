import 'package:flutter/material.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final Function(String value)? onChanged;
  final IconData icon;

  const TextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    required this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          prefixIconColor: context.theme.primaryColor,
          labelStyle:
              TextStyle(fontSize: 13, color: context.theme.primaryColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: context.theme.primaryColor!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.brown,
            ),
          ),
        ),
      ),
    );
  }
}
