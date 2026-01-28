import 'package:haptext_api/exports.dart';

class Tab1 extends StatelessWidget {
  final List<ResultPostModel> photoPosts;

  const Tab1({super.key, required this.photoPosts});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 1.2,
          mainAxisSpacing: 1.2,
        ),
        itemCount: photoPosts.length,
        itemBuilder: (BuildContext context, int index) => AppNetwokImage(
            height: 20,
            width: 20,
            imageUrl: photoPosts[index].mediaFiles?.first.imageFile ?? ''));
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
