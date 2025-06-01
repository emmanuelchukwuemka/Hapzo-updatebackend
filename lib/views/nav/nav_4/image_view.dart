import 'package:flutter/material.dart';
import 'package:haptext_api/views/nav/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class ImageView extends StatefulWidget {
  const ImageView({Key? key}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.bgColor,
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/images/asta.jpg'),
              fit: BoxFit.contain,
            ),
          ),
          Center(
            child: Image(
              image: AssetImage('assets/images/me.jpg'),
              fit: BoxFit.contain,
            ),
          ),
          Center(
            child: Image(
              image: AssetImage('assets/images/vegeta.jpg'),
              fit: BoxFit.contain,
            ),
          ),
          Center(
            child: Image(
              image: AssetImage('assets/images/sasuke.jpg'),
              fit: BoxFit.contain,
            ),
          ),
          Center(
            child: Image(
              image: AssetImage('assets/images/yuno.jpg'),
              fit: BoxFit.contain,
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => SeeAll()),);
              },
              child: Text(
                'See all posts',
                style: TextStyle(
                  color: context.theme.titleTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ),
        ]
      ),
    );
  }
}
