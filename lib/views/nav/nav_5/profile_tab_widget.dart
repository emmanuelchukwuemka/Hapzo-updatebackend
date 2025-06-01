import 'package:flutter/material.dart';
import 'package:haptext_api/views/nav/exports.dart';

class ProfileTabWidget extends StatefulWidget {
  const ProfileTabWidget({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  State<ProfileTabWidget> createState() => _ProfileTabWidgetState();
}

class _ProfileTabWidgetState extends State<ProfileTabWidget> {

  int current = 0;
  List<String> items = [
    "Pictures",
    "Videos",
    "Texts",
    "Audios",
    "Downloads",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      // padding: const EdgeInsets.all(5.0),
      children: [
        TabBar(
          // labelColor: context.theme.primaryColor,
          labelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12.0),
          // unselectedLabelColor: context.theme.greyColor,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
          controller: widget.tabController,
          // indicatorColor: context.theme.primaryColor,
          tabs: [
            Tab(text: 'Pictures'),
            Tab(text: 'Videos'),
            // Expanded(child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Tab(text: 'Comments & Replies'))),
            Tab(text: 'Texts'),
            Tab(text: 'Audios'),
            Tab(text: 'Downloads'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: widget.tabController,
            children: const [
              Tab1(),
              Tab2(),
              Tab3(),
              Tab4(),
              Tab5(),
            ]
          ),
        ),
      ]
    );
  }
}