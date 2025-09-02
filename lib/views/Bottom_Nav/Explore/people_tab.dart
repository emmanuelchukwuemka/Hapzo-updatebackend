import 'package:flutter/material.dart';

class PeopleTab extends StatefulWidget {
  const PeopleTab({Key? key}) : super(key: key);

  @override
  State<PeopleTab> createState() => _PeopleTabState();
}

class _PeopleTabState extends State<PeopleTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('PEOPLE'),
    );
  }
}
