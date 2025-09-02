import 'package:flutter/material.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class SearchOptionTabWidget extends StatelessWidget {
  const SearchOptionTabWidget({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
        // padding: const EdgeInsets.all(5.0),
        children: [
          TabBar(
            labelColor: context.theme.primaryColor,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 12.0),
            unselectedLabelColor: context.theme.greyColor,
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w300),
            controller: tabController,
            indicatorColor: context.theme.primaryColor,
            tabs: const [
              Tab(text: 'Posts'),
              Tab(text: 'People'),
            ],
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: const [
              PostTab(),
              PeopleTab(),
            ]),
          ),
        ]);
  }
}
