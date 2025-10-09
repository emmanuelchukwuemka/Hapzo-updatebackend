import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';
import 'package:haptext_api/bloc/people/cubit/people_cubit.dart';
import 'package:haptext_api/common/text_input_field.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

import '../views/Bottom_Nav/Explore/search_option_tab.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: context.theme.bgColor,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 10),
          Container(
              height: size.height * .08,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextInputField(
                  controller: _searchController,
                  labelText: 'Search',
                  onChanged: (value) {
                    context.read<PeopleCubit>().searchFriends(query: "string");
                  },
                  icon: Icons.search)),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: SearchOptionTabWidget(tabController: tabController),
          ),
        ]),
      ),
    );
  }
}
