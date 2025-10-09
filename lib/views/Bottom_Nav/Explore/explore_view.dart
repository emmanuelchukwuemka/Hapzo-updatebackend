import 'package:flutter/material.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';

class XploreTab1 extends StatelessWidget {
  const XploreTab1({Key? key}) : super(key: key);

  // final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return ExploreCarousel(tabIndex: index, title: sections[index]);
        });
  }

  final sections = const ["Trending", "Most Liked", "Most Shared"];
}
