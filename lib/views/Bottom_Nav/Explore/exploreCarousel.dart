import 'package:flutter/material.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class ExploreCarousel extends StatefulWidget {
  final String title;
  const ExploreCarousel({Key? key, required this.title}) : super(key: key);

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
    'assets/images/chukwuchi.jpg',
  ];

  final List<Color> _type = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.pinkAccent,
    Colors.green,
    Colors.orange,
    Colors.blue,
  ];

  final List<IconData> _icn = [
    Icons.audiotrack,
    Icons.video_library_outlined,
    Icons.image_rounded,
    Icons.image_rounded,
    Icons.image_rounded,
    Icons.audiotrack,
    Icons.video_library_outlined,
    Icons.image_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.width * 1.2,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: context.theme.appBarColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 15,
              bottom: 5.0,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.title,
                style: TextStyle(
                    color: context.theme.titleTextColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500),
                // textAlign: TextAlign.left,
              ),
            ),
          ),
          // This should be a GridView
          Expanded(
            child: GridView.builder(
              physics: const FixedExtentScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.5,
                mainAxisSpacing: 2.5,
              ),
              itemCount: _imgs.length,
              itemBuilder: (context, index) => ExploreItem(
                size: size,
                imgPath: _imgs[index],
                fileType: _type[index],
                category: _icn[index],
              ),
              // children: [
              //   ExploreItem(size: size, imgPath: 'assets/images/yuno.jpg', fileType: 'image',),
              //   ExploreItem(size: size, imgPath: 'assets/images/asta.jpg', fileType: 'image',),
              //   ExploreItem(size: size, imgPath: 'assets/images/me.jpg', fileType: 'image',),
              //   ExploreItem(size: size, imgPath: 'assets/images/chukwuchi.jpg', fileType: 'image',),
              //   ExploreItem(size: size, imgPath: 'assets/images/asta.jpg', fileType: 'image',),
              //   ExploreItem(size: size, imgPath: 'assets/images/yuno.jpg', fileType: 'image',),
              //   ExploreItem(size: size, imgPath: 'assets/images/chukwuchi.jpg', fileType: 'image',),
              //   ExploreItem(size: size, imgPath: 'assets/images/me.jpg', fileType: 'image',),
              //   ExploreItem(size: size, imgPath: 'assets/images/yuno.jpg', fileType: 'image',),
              //   ExploreItem(size: size, imgPath: 'assets/images/yuno.jpg', fileType: 'image',),
              //   ExploreItem(size: size, imgPath: 'assets/images/yuno.jpg', fileType: 'image',),
              // ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Trending(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, bottom: 15.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'See more',
                  style: TextStyle(
                    color: context.theme.primaryColor,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExploreItem extends StatelessWidget {
  const ExploreItem({
    super.key,
    required this.size,
    required this.imgPath,
    required this.fileType,
    required this.category,
  });

  final Size size;
  final String imgPath;
  final Color fileType;
  final IconData category;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TrendingContent(),
              ));
        },
        child: Container(
          height: size.width * .32,
          width: size.width * .32,
          decoration: BoxDecoration(
            color: context.theme.bgColor,
            border: Border.all(
              color: fileType,
              width: 1.50,
              style: BorderStyle.solid,
            ),
            // borderRadius: BorderRadius.circular(12.0)
          ),
          child: Image(
            image: AssetImage(imgPath),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: const EdgeInsets.only(right: 7.0, top: 7.0),
          child: Container(
            height: 17.0,
            width: 17.0,
            decoration: BoxDecoration(
              color: context.theme.bgColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Icon(
                category,
                color: fileType,
                size: 14,
              ),
            ),
          ),
        ),
        // fileType == image ? Icon(Icons.video_library_outlined, color: Colors.white70, size: 12,) : SizedBox.shrink(),
      ),
    ]);
  }
}
