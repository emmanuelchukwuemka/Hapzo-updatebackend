import 'package:flutter/material.dart';

class PostTab extends StatefulWidget {
  const PostTab({Key? key}) : super(key: key);

  @override
  State<PostTab> createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "This is a searched post containing the word Flutter...",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ReactionIcon(icon: Icons.favorite, label: "1.2k"),
                    _ReactionIcon(icon: Icons.comment, label: "230"),
                    _ReactionIcon(icon: Icons.share, label: "85"),
                    _ReactionIcon(icon: Icons.download, label: "50"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ReactionIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ReactionIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.white70),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(fontSize: 13, color: Colors.white70)),
      ],
    );
  }
}
