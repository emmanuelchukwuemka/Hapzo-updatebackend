import 'package:flutter/material.dart';

class Tab2 extends StatefulWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {

  List<String> myPictures = [
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/sasuke.jpg',
    'assets/images/yuno.jpg',
    'assets/images/vegeta.jpg',
    'assets/images/me.jpg',
    'assets/images/me.jpg',
    'assets/images/sasuke.jpg',
    'assets/images/asta.jpg',
    'assets/images/yuno.jpg',
    'assets/images/vegeta.jpg',
    'assets/images/me.jpg',
    'assets/images/me.jpg',
    'assets/images/sasuke.jpg',
    'assets/images/asta.jpg',
    'assets/images/yuno.jpg',
    'assets/images/vegeta.jpg',
    'assets/images/me.jpg',
    'assets/images/me.jpg',
    'assets/images/sasuke.jpg',
    'assets/images/asta.jpg',
    'assets/images/yuno.jpg',
    'assets/images/vegeta.jpg',
    'assets/images/me.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/sasuke.jpg',
    'assets/images/yuno.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 1.2,
          mainAxisSpacing: 1.2,
      ),
      itemCount: myPictures.length,
      itemBuilder: (BuildContext context, int index) => Container(
        // height: 185,
        // width: 158,
        child: Image(
          image: AssetImage(myPictures[index]),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
