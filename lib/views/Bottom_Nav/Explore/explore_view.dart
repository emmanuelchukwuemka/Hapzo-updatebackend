import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/common/coloors.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';

class XploreTab1 extends StatefulWidget {
  const XploreTab1({Key? key}) : super(key: key);

  @override
  State<XploreTab1> createState() => _XploreTab1State();
}

class _XploreTab1State extends State<XploreTab1> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().fetchPosts(feedType: "trending");
      context.read<HomeCubit>().fetchPosts(feedType: "popular");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search posts or hashtags",
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon: const Icon(Icons.search, color: Colors.white38),
                filled: true,
                fillColor: context.theme.surfaceColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 3. Content Grid
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return ExploreCarousel(tabIndex: index, title: sections[index]);
              }),
        ],
      ),
    );
  }

  final sections = const ["Trending", "Most Liked", "Most Shared"];
}
