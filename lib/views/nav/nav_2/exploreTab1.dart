import 'package:flutter/material.dart';
import 'package:haptext_api/views/nav/exports.dart';

class XploreTab1 extends StatelessWidget {
  XploreTab1({Key? key}) : super(key: key);

  // final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.0),
          // Trending Container
          ExploreCarousel(title: 'Trending'),
          SizedBox(height: 10.0),
          // Most liked
          ExploreCarousel(title: 'Most liked'),
          SizedBox(height: 10.0),
          // Most shared
          ExploreCarousel(title: 'Most shared',),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
