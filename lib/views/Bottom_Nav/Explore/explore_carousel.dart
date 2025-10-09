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
  final List<String> _imgs = [
    'assets/images/sasuke.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/chukwuchi.jpg',
    'assets/images/yuno.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/chukwuchi.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              10.verticalSpace,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                AppText(
                    text: widget.title,
                    color: context.theme.titleTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Trending()));
                    },
                    child: const AppText(text: "See more", color: Colors.white
                        // fontSize: 15,
                        ))
              ]),
              15.verticalSpace,
              SizedBox(
                  height: size.height * 0.63,
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 2.5,
                              mainAxisSpacing: 2.5),
                      itemCount: _imgs.length,
                      itemBuilder: (context, index) => PostCard(
                          index: index,
                          relation: widget.tabIndex == 0
                              ? "follow"
                              : widget.tabIndex == 1
                                  ? "followsYou"
                                  : "contact"))),
              20.verticalSpace
            ]));
  }
}

class PostCard extends StatelessWidget {
  final String relation;
  final int index;

  const PostCard({super.key, required this.relation, required this.index});

  @override
  Widget build(BuildContext context) {
    // Glow border color
    Color glowColor;
    switch (relation) {
      case "follow":
        glowColor = Colors.blueAccent;
        break;
      case "followsYou":
        glowColor = Colors.pinkAccent;
        break;
      case "contact":
        glowColor = Colors.greenAccent;
        break;
      default:
        glowColor = Colors.transparent;
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (relation.isNotEmpty)
              BoxShadow(
                  color: glowColor.withOpacity(0.6),
                  blurRadius: 12,
                  spreadRadius: 1),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              AppshadowContainer(
                  color: Colors.grey[850],
                  child: const Center(
                      child:
                          Icon(Icons.image, size: 60, color: Colors.white54))),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _OverlayIcon(icon: Icons.favorite, count: "1.2k"),
                      _OverlayIcon(icon: Icons.comment, count: "300"),
                      _OverlayIcon(icon: Icons.share, count: "150"),
                      _OverlayIcon(icon: Icons.download, count: "90"),
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

class _OverlayIcon extends StatelessWidget {
  final IconData icon;
  final String count;

  const _OverlayIcon({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: Colors.white70, size: 18),
      const SizedBox(width: 4),
      AppText(text: count, fontSize: 12, color: Colors.white70)
    ]);
  }
}
