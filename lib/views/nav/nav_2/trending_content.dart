import 'package:flutter/material.dart';
import 'package:haptext_api/views/nav/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class TrendingContent extends StatefulWidget {
  const TrendingContent({Key? key}) : super(key: key);

  @override
  State<TrendingContent> createState() => _TrendingContentState();
}

class _TrendingContentState extends State<TrendingContent> {

  List<String> names = [
    'Sakura',
    'Naruto Uzumaki',
    'Noelle',
    'Praiz',
    'Asta',
    'Gojo Satoru',
    'Noelle',
    'Confidence',
    'Sakura',
    'Naruto Uzumaki',
    'Noelle',
    'Praiz',
    'Asta',
    'Gojo Satoru',
    'Noelle',
    'Confidence',
    'Sakura',
    'Naruto Uzumaki',
    'Noelle',
    'Praiz',
    'Asta',
    'Gojo Satoru',
    'Noelle',
    'Confidence',
  ];

  List<String> imgs = [
    'assets/images/sasuke.jpg',
    'assets/images/me.jpg',
    'assets/images/landscape4.jpg',
    'assets/images/chukwuchi.jpg',
    'assets/images/yuno.jpg',
    'assets/images/me.jpg',
    'assets/images/landscape3.jpg',
    'assets/images/chukwuchi.jpg',
    'assets/images/landscape1.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/landscape2.jpg',
    'assets/images/yuno.jpg',
    'assets/images/me.jpg',
    'assets/images/landscape4.jpg',
    'assets/images/chukwuchi.jpg',
    'assets/images/sasuke.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/chukwuchi.jpg',
    'assets/images/yuno.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/landscape3.jpg',
  ];

  List<String> profilePics = [
    'assets/images/yuno.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/chukwuchi.jpg',
    'assets/images/sasuke.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/chukwuchi.jpg',
    'assets/images/yuno.jpg',
    'assets/images/me.jpg',
    'assets/images/yuno.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/chukwuchi.jpg',
    'assets/images/sasuke.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/chukwuchi.jpg',
    'assets/images/yuno.jpg',
    'assets/images/me.jpg',
  ];

  List<String> category = [
    'Random',
    'Your Friend',
    'Following',
    'Your Contact',
    'Follower',
    'Your Friend',
    'Following',
    'Your Contact',
    'Random',
    'Your Friend',
    'Following',
    'Your Contact',
    'Follower',
    'Your Friend',
    'Following',
    'Your Contact',
    'Random',
    'Your Friend',
    'Following',
    'Your Contact',
    'Follower',
    'Your Friend',
    'Following',
    'Your Contact',
  ];

  List<Color> type = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.pinkAccent,
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.pinkAccent,
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.pinkAccent,
    Colors.green,
    Colors.orange,
    Colors.blue,
  ];

  List<IconData> icn = [
    Icons.audiotrack,
    Icons.video_library_outlined,
    Icons.image_rounded,
    Icons.image_rounded,
    Icons.image_rounded,
    Icons.audiotrack,
    Icons.video_library_outlined,
    Icons.image_rounded,
    Icons.audiotrack,
    Icons.video_library_outlined,
    Icons.image_rounded,
    Icons.image_rounded,
    Icons.image_rounded,
    Icons.audiotrack,
    Icons.video_library_outlined,
    Icons.image_rounded,
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
    return Scaffold(
      backgroundColor: context.theme.appBarColor,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: imgs.length,
        itemBuilder: (BuildContext context, int index) => Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Image(
                image: AssetImage(imgs[index]),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      names[index],
                      style: TextStyle(
                        color: context.theme.titleTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 2.5),
                    Text(
                      '1 hour ago',
                      style: TextStyle(
                        color: context.theme.titleTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      // color: Colors.white10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: size.width * .54,
                            height: size.height * .15,
                            // color: Colors.white24,
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 45.0,
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 21,
                                        backgroundColor: type[index],
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(profilePics[index],),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        width: 100,
                                        height: 35.0,
                                        decoration: BoxDecoration(
                                          color: type[index],
                                          borderRadius: BorderRadius.circular(7.5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            category[index],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                            ),
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Expanded(
                                  child: Text(
                                    'I just need some time, I\'m tryin think straight, I just need a moment in my own space.. ask me how I\'m doin I\'ll say "OK" Yeah, cos that\'s just what we all say. Sometimes I think back to the old days, in a pointless conversation with the old me, back when my mama used to hold me, I wish somebody would have told me...',
                                    style: TextStyle(
                                      color: context.theme.textColor,
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                                // Row(
                                //   children: [
                                //     Container(
                                //       height: 50,
                                //       width: 50,
                                //       decoration: BoxDecoration(
                                //         color: Colors.grey[100],
                                //         borderRadius: BorderRadius.circular(25)
                                //       )
                                //     ),
                                //     SizedBox(width: 5),
                                //     Container(
                                //       width: 50,
                                //       height: 18,
                                //       color: Colors.grey[100],
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          Container(
                            width: 85.0,
                            // margin: EdgeInsets.only(bottom: size.height * .025),
                            // color: Colors.black12,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // buildProfile(data.profilePhoto),
                                SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          // => videoController.likeVideo(data.id),
                                          child: Icon(Icons.favorite, size: 30, color: context.theme.primaryColor,),
                                        ),
                                        // Text(
                                        //   // data.likes.length.toString(),
                                        //   '271',
                                        //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
                                        // ),
                                      ],
                                    ),
                                    // SizedBox(width: 20),
                                    Column(
                                      children: [
                                        InkWell(onTap: () {}, child: Icon(Icons.mode_comment_rounded, size: 30, color: context.theme.primaryColor,),),
                                        // Text(
                                        //   // data.commentCount.toString(),
                                        //   '29',
                                        //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Icon(Icons.reply, size: 30, color: context.theme.primaryColor,),
                                        ),
                                        // Text(
                                        //   // data.shareCount.toString(),
                                        //   '2',
                                        //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
                                      ],
                                    ),
                                    // SizedBox(width: 20),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Icon(Icons.download, size: 30, color: context.theme.primaryColor,),
                                        ),
                                        // Text(
                                        //   // data.shareCount.toString(),
                                        //   '2',
                                        //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // buildPostContainer('assets/images/unsplash.jpg'),
      ),
    );
  }
}
