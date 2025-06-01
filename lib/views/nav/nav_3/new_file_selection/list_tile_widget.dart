import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onClicked;

  const ListTileWidget({Key? key, required this.text, required this.icon, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
    title: Text(text),
    leading: Icon(icon, size: 28, color: Colors.black),
    onTap: onClicked,
  );
}
