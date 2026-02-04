import 'package:flutter/material.dart';
import 'package:haptext_api/common/coloors.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';

class XploreTab1 extends StatelessWidget {
  const XploreTab1({Key? key}) : super(key: key);

  // final TextEditingController _searchController = TextEditingController();

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

          // 2. Trending Hashtags
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _hashtagChip("#home", "2k"),
                _hashtagChip("#viral", "1.5k"),
                _hashtagChip("#trending", "1.2k"),
                _hashtagChip("#flutter", "800"),
                _hashtagChip("#social", "500"),
              ],
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

  Widget _hashtagChip(String tag, String count) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Text(tag,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(width: 4),
          Text("($count)",
              style: const TextStyle(color: Colors.white38, fontSize: 12)),
        ],
      ),
    );
  }

  final sections = const ["Trending", "Most Liked", "Most Shared"];
}
