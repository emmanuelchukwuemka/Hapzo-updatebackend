import 'package:flutter/material.dart';
// import 'package:main_hapztext/controllers/exports.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
