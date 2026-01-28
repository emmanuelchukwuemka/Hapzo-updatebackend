import 'package:flutter/material.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/models/posts_model.dart';

class ProfileAudioTab extends StatelessWidget {
  final List<ResultPostModel> audioPosts;

  const ProfileAudioTab({super.key, required this.audioPosts});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 1.2,
          mainAxisSpacing: 1.2,
        ),
        itemCount: audioPosts.length,
        itemBuilder: (BuildContext context, int index) =>
            const AppshadowContainer());
  }
}
