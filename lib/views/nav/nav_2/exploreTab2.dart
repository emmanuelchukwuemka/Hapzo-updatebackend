 
import 'package:haptext_api/common/theme/custom_theme_extension.dart';
import 'package:haptext_api/exports.dart';

class XploreTab2 extends StatefulWidget {
  const XploreTab2({Key? key}) : super(key: key);

  @override
  State<XploreTab2> createState() => _XploreTab2State();
}

class _XploreTab2State extends State<XploreTab2> {
  late final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 7.50),
          Container(
            width: size.width,
            height: size.height * .705,
            margin: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: const Image(
                      height: double.infinity,
                      width: double.infinity,
                      image: AssetImage('assets/images/landscape1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage('assets/images/sasuke.jpg'),
                              ),
                              SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fortune',
                                    style: TextStyle(
                                      color: Color(0xFFFD6104),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '52 mins ago',
                                    style: TextStyle(
                                      color: Color(0xFFFD6104),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                             
                            },
                            child: const Text(
                              'Follow',
                              style: TextStyle(
                                color: Color(0xFFFD6104),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            // color: Colors.white70,
                            child: ListView(
                                padding: const EdgeInsets.only(left: 10),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 120,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 7.5),
                                    margin: const EdgeInsets.only(right: 25.0),
                                    decoration: BoxDecoration(
                                      border: const Border(
                                        top: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 3.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                        right: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                        bottom: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                        left: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                      color: Colors.black54,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Comment',
                                        style: TextStyle(
                                          color: context.theme.primaryColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.thumb_up,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.favorite_outlined,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.face,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.image_rounded,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.audiotrack,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.video_library_outlined,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.person,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            height: 1.5,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '00:00',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '2:05:19',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                )
                              ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 7.50),
          Container(
            width: size.width,
            height: size.height * .705,
            margin: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: const Image(
                      height: double.infinity,
                      width: double.infinity,
                      image: AssetImage('assets/images/landscape2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage('assets/images/sasuke.jpg'),
                              ),
                              SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fortune',
                                    style: TextStyle(
                                      color: Color(0xFFFD6104),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '52 mins ago',
                                    style: TextStyle(
                                      color: Color(0xFFFD6104),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                            
                            },
                            child: const Text(
                              'Follow',
                              style: TextStyle(
                                color: Color(0xFFFD6104),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            // color: Colors.white70,
                            child: ListView(
                                padding: const EdgeInsets.only(left: 10),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 120,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 7.5),
                                    margin: const EdgeInsets.only(right: 25.0),
                                    decoration: BoxDecoration(
                                      border: const Border(
                                        top: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 3.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                        right: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                        bottom: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                        left: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                      color: Colors.black54,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Comment',
                                        style: TextStyle(
                                          color: context.theme.primaryColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.thumb_up,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.favorite_outlined,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.face,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.image_rounded,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.audiotrack,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.video_library_outlined,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.person,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            height: 1.5,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '00:00',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '2:05:19',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                )
                              ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 7.50),
          Container(
            width: size.width,
            height: size.height * .705,
            margin: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: const Image(
                      height: double.infinity,
                      width: double.infinity,
                      image: AssetImage('assets/images/landscape4.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage('assets/images/sasuke.jpg'),
                              ),
                              SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fortune',
                                    style: TextStyle(
                                      color: Color(0xFFFD6104),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '52 mins ago',
                                    style: TextStyle(
                                      color: Color(0xFFFD6104),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                             
                            },
                            child: const Text(
                              'Follow',
                              style: TextStyle(
                                color: Color(0xFFFD6104),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            // color: Colors.white70,
                            child: ListView(
                                padding: const EdgeInsets.only(left: 10),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 120,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 7.5),
                                    margin: const EdgeInsets.only(right: 25.0),
                                    decoration: BoxDecoration(
                                      border: const Border(
                                        top: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 3.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                        right: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                        bottom: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                        left: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                      color: Colors.black54,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Comment',
                                        style: TextStyle(
                                          color: context.theme.primaryColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.thumb_up,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.favorite_outlined,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.face,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.image_rounded,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.audiotrack,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.video_library_outlined,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.person,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            height: 1.5,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '00:00',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '2:05:19',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                )
                              ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 7.50),
          Container(
            width: size.width,
            height: size.height * .705,
            margin: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: const Image(
                      height: double.infinity,
                      width: double.infinity,
                      image: AssetImage('assets/images/landscape3.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage('assets/images/sasuke.jpg'),
                              ),
                              SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fortune',
                                    style: TextStyle(
                                      color: Color(0xFFFD6104),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '52 mins ago',
                                    style: TextStyle(
                                      color: Color(0xFFFD6104),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                            
                            },
                            child: const Text(
                              'Follow',
                              style: TextStyle(
                                color: Color(0xFFFD6104),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            // color: Colors.white70,
                            child: ListView(
                                padding: const EdgeInsets.only(left: 10),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 120,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 7.5),
                                    margin: const EdgeInsets.only(right: 25.0),
                                    decoration: BoxDecoration(
                                      border: const Border(
                                        top: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 3.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                        right: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                        bottom: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                        left: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1.0,
                                          color: Color(0xFFFD6104),
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(35),
                                      color: Colors.black54,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Comment',
                                        style: TextStyle(
                                          color: context.theme.primaryColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.thumb_up,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.favorite_outlined,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.face,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.image_rounded,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.audiotrack,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.video_library_outlined,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        Icons.person,
                                        color: Color(0xFFFD6104),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            height: 1.5,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '00:00',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '2:05:19',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                )
                              ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
