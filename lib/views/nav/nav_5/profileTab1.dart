import 'package:flutter/material.dart';

class Tab1 extends StatefulWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {

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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
      // children: [
      //   Row(
      //     children: [
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/asta.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       // SizedBox(width: 3),
      //       // Container(
      //       //   height: 185,
      //       //   width: 158,
      //       //   child: Image(
      //       //     image: AssetImage('assets/images/vegeta.jpg'),
      //       //     fit: BoxFit.cover,
      //       //   ),
      //       // ),
      //       // SizedBox(width: 3),
      //       // Container(
      //       //   height: 185,
      //       //   width: 158,
      //       //   child: Image(
      //       //     image: AssetImage('assets/images/yuno.jpg'),
      //       //     fit: BoxFit.cover,
      //       //   ),
      //       // ),
      //     ],
      //   ),
      //   SizedBox(height: 3.0),
      //   Row(
      //     children: [
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/asta.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       SizedBox(width: 3),
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/vegeta.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       SizedBox(width: 3),
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/yuno.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ],
      //   ),
      //   SizedBox(height: 3.0),
      //   Row(
      //     children: [
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/asta.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       SizedBox(width: 3),
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/vegeta.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       SizedBox(width: 3),
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/yuno.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ],
      //   ),
      //   SizedBox(height: 3.0),
      //   Row(
      //     children: [
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/asta.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       SizedBox(width: 3),
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/vegeta.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       SizedBox(width: 3),
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/yuno.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ],
      //   ),
      //   SizedBox(height: 3.0),
      //   Row(
      //     children: [
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/asta.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       SizedBox(width: 3),
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/vegeta.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       SizedBox(width: 3),
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/yuno.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ],
      //   ),
      //   SizedBox(height: 3.0),
      //   Row(
      //     children: [
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/asta.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       SizedBox(width: 3),
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/vegeta.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       SizedBox(width: 3),
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/yuno.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ],
      //   ),
      //   SizedBox(height: 3.0),
      //   Row(
      //     children: [
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/asta.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       SizedBox(width: 3),
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/vegeta.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       SizedBox(width: 3),
      //       Container(
      //         height: 185,
      //         width: 158,
      //         child: Image(
      //           image: AssetImage('assets/images/yuno.jpg'),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ],
      //   ),
      //   SizedBox(height: 12.0),
      // ],
  }
}
