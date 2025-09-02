import 'package:flutter/material.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';

class XploreTab1 extends StatelessWidget {
  const XploreTab1({Key? key}) : super(key: key);

  // final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10.0),
          // Trending Container
          ExploreCarousel(title: 'Trending'),
          const SizedBox(height: 10.0),
          // Most liked
          ExploreCarousel(title: 'Most liked'),
          const SizedBox(height: 10.0),
          // Most shared
          ExploreCarousel(
            title: 'Most shared',
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
