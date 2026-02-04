import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class ExploreCarousel extends StatefulWidget {
  final String title;
  final int tabIndex;
  const ExploreCarousel({Key? key, required this.title, required this.tabIndex})
      : super(key: key);

  @override
  State<ExploreCarousel> createState() => _ExploreCarouselState();
}

class _ExploreCarouselState extends State<ExploreCarousel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                AppText(
                    text: widget.title,
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Trending()));
                    },
                    child: AppText(
                        text: "See more",
                        color: context.theme.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600))
              ]),
              const SizedBox(height: 12),
              MasonryGridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: 9,
                itemBuilder: (context, index) {
                  // Simulate different heights for masonry effect
                  double height = (index % 3 == 0) ? 180 : (index % 3 == 1) ? 240 : 150;
                  return SocialPostCard(
                    height: height,
                    isTrending: index == 0,
                  );
                },
              ),
              const SizedBox(height: 24)
            ]));
  }
}

class SocialPostCard extends StatelessWidget {
  final double height;
  final bool isTrending;

  const SocialPostCard({super.key, required this.height, this.isTrending = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: context.theme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // 1. Media Display Placeholder
              Positioned.fill(
                child: Container(
                  color: Colors.white.withOpacity(0.05),
                  child: const Center(
                    child: Icon(Icons.play_circle_outline, color: Colors.white24, size: 30),
                  ),
                ),
              ),

              // 2. Trending Badge
              if (isTrending)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "TRENDING",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // 3. Metrics Overlay & Gradient
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _MetricItem(icon: Icons.favorite_border, count: "1.2k"),
                          _MetricItem(icon: Icons.repeat, count: "450"),
                          _MetricItem(icon: Icons.chat_bubble_outline, count: "120"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final IconData icon;
  final String count;

  const _MetricItem({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 10),
        const SizedBox(width: 2),
        Text(
          count,
          style: const TextStyle(color: Colors.white, fontSize: 8),
        ),
      ],
    );
  }
}
