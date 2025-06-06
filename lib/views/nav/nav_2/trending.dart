import 'package:flutter/material.dart';
import 'package:haptext_api/views/nav/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  List<String> imgs = [
    'assets/images/sasuke.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/chukwuchi.jpg',
    'assets/images/yuno.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/chukwuchi.jpg',
    'assets/images/sasuke.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/chukwuchi.jpg',
    'assets/images/yuno.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/chukwuchi.jpg',
    'assets/images/sasuke.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/chukwuchi.jpg',
    'assets/images/yuno.jpg',
    'assets/images/me.jpg',
    'assets/images/asta.jpg',
    'assets/images/chukwuchi.jpg',
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
      backgroundColor: context.theme.bgColor,
      appBar: AppBar(
        backgroundColor: context.theme.appBarColor,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: context.theme.primaryColor,
        ),
        title: Text(
          '  Trending',
          style: TextStyle(
            color: context.theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(5),
        // physics: FixedExtentScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.5,
          mainAxisSpacing: 2.5,
        ),
        itemCount: imgs.length,
        itemBuilder: (context, index) => ExploreItem(
          size: size,
          imgPath: imgs[index],
          fileType: type[index],
          category: icn[index],
        ),
      ),
      // PageView(
      //     scrollDirection: Axis.vertical,
      //     children: [
      //       Container(
      //         margin: const EdgeInsets.all(10),
      //         padding: const EdgeInsets.all(15),
      //         width: size.width - 20,
      //         height: size.height,
      //         decoration: BoxDecoration(
      //             color: context.theme.appBarColor,
      //             // color: context.theme.bgColor,
      //             borderRadius: BorderRadius.circular(20),
      //             boxShadow: [BoxShadow(
      //               blurRadius: 1.0,
      //               offset: Offset(0.8, 0.5),
      //               color: Colors.black54,
      //             )]
      //         ),
      //         child: Stack(
      //           children: [
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 const SizedBox(height: 15),
      //                 Container(
      //                   width: 120,
      //                   height: 30,
      //                   color: Colors.white12,
      //                 ),
      //                 SizedBox(height: 5),
      //                 Container(
      //                   width: 110,
      //                   height: 18,
      //                   color: Colors.white12,
      //                 ),
      //                 Container(
      //                   height: 50,
      //                   width: double.infinity,
      //                   // color: Colors.white10,
      //                 ),
      //                 Expanded(
      //                   child: Row(
      //                     mainAxisSize: MainAxisSize.max,
      //                     crossAxisAlignment: CrossAxisAlignment.end,
      //                     children: [
      //                       Expanded(
      //                         child: Container(
      //                           padding: const EdgeInsets.only(left: 10),
      //                           child: Column(
      //                             mainAxisSize: MainAxisSize.min,
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                             children: [
      //                               Row(
      //                                 children: [
      //                                   CircleAvatar(
      //                                     radius: 20,
      //                                     backgroundColor: Colors.white12,
      //                                   ),
      //                                   SizedBox(width: 5),
      //                                   Container(
      //                                     width: 80,
      //                                     height: 25,
      //                                     color: Colors.white12,
      //                                   ),
      //                                 ],
      //                               ),
      //                               SizedBox(height: 5),
      //                               Container(
      //                                 width: 120,
      //                                 height: 15,
      //                                 color: Colors.white12,
      //                               ),
      //                               SizedBox(height: 5),
      //                               Container(
      //                                 width: 120,
      //                                 height: 15,
      //                                 color: Colors.white12,
      //                               ),
      //                               SizedBox(height: 25),
      //                               // Row(
      //                               //   children: [
      //                               //     Container(
      //                               //       height: 50,
      //                               //       width: 50,
      //                               //       decoration: BoxDecoration(
      //                               //         color: Colors.grey[100],
      //                               //         borderRadius: BorderRadius.circular(25)
      //                               //       )
      //                               //     ),
      //                               //     SizedBox(width: 5),
      //                               //     Container(
      //                               //       width: 50,
      //                               //       height: 18,
      //                               //       color: Colors.grey[100],
      //                               //     ),
      //                               //   ],
      //                               // ),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         width: 80,
      //                         // margin: EdgeInsets.only(bottom: size.height * .025),
      //                         // color: Colors.black12,
      //                         child: Column(
      //                           mainAxisAlignment: MainAxisAlignment.end,
      //                           children: [
      //                             // buildProfile(data.profilePhoto),
      //                             SizedBox(height: 25),
      //                             Row(
      //                               children: [
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       // => videoController.likeVideo(data.id),
      //                                       child: Icon(Icons.favorite, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.likes.length.toString(),
      //                                     //   '271',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
      //                                     // ),
      //                                   ],
      //                                 ),
      //                                 SizedBox(width: 20),
      //                                 Column(
      //                                   children: [
      //                                     InkWell(onTap: () {}, child: Icon(Icons.mode_comment_rounded, size: 30, color: Colors.white12,),),
      //                                     // Text(
      //                                     //   // data.commentCount.toString(),
      //                                     //   '29',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
      //                                     // ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 25),
      //                             Row(
      //                               children: [
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       child: Icon(Icons.reply, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.shareCount.toString(),
      //                                     //   '2',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
      //                                   ],
      //                                 ),
      //                                 SizedBox(width: 20),
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       child: Icon(Icons.download, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.shareCount.toString(),
      //                                     //   '2',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 20),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             // Center(
      //             //   child: CircularProgressIndicator(),
      //             // ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.all(10),
      //         padding: const EdgeInsets.all(15),
      //         width: size.width - 20,
      //         height: size.height,
      //         decoration: BoxDecoration(
      //           // color: context.theme.bgColor,
      //             color: context.theme.appBarColor,
      //             borderRadius: BorderRadius.circular(20),
      //             boxShadow: [BoxShadow(
      //               blurRadius: 1.0,
      //               offset: Offset(0.8, 0.5),
      //               color: Colors.black54,
      //             )]
      //         ),
      //         child: Stack(
      //           children: [
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 const SizedBox(height: 15),
      //                 Container(
      //                   width: 120,
      //                   height: 30,
      //                   color: Colors.white12,
      //                 ),
      //                 SizedBox(height: 5),
      //                 Container(
      //                   width: 110,
      //                   height: 18,
      //                   color: Colors.white12,
      //                 ),
      //                 Container(
      //                   height: 50,
      //                   width: double.infinity,
      //                   // color: Colors.white10,
      //                 ),
      //                 Expanded(
      //                   child: Row(
      //                     mainAxisSize: MainAxisSize.max,
      //                     crossAxisAlignment: CrossAxisAlignment.end,
      //                     children: [
      //                       Expanded(
      //                         child: Container(
      //                           padding: const EdgeInsets.only(left: 10),
      //                           child: Column(
      //                             mainAxisSize: MainAxisSize.min,
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                             children: [
      //                               Row(
      //                                 children: [
      //                                   CircleAvatar(
      //                                     radius: 20,
      //                                     backgroundColor: Colors.white12,
      //                                   ),
      //                                   SizedBox(width: 5),
      //                                   Container(
      //                                     width: 80,
      //                                     height: 25,
      //                                     color: Colors.white12,
      //                                   ),
      //                                 ],
      //                               ),
      //                               SizedBox(height: 5),
      //                               Container(
      //                                 width: 120,
      //                                 height: 15,
      //                                 color: Colors.white12,
      //                               ),
      //                               SizedBox(height: 5),
      //                               Container(
      //                                 width: 120,
      //                                 height: 15,
      //                                 color: Colors.white12,
      //                               ),
      //                               SizedBox(height: 25),
      //                               // Row(
      //                               //   children: [
      //                               //     Container(
      //                               //       height: 50,
      //                               //       width: 50,
      //                               //       decoration: BoxDecoration(
      //                               //         color: Colors.grey[100],
      //                               //         borderRadius: BorderRadius.circular(25)
      //                               //       )
      //                               //     ),
      //                               //     SizedBox(width: 5),
      //                               //     Container(
      //                               //       width: 50,
      //                               //       height: 18,
      //                               //       color: Colors.grey[100],
      //                               //     ),
      //                               //   ],
      //                               // ),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         width: 80,
      //                         // margin: EdgeInsets.only(bottom: size.height * .025),
      //                         // color: Colors.black12,
      //                         child: Column(
      //                           mainAxisAlignment: MainAxisAlignment.end,
      //                           children: [
      //                             // buildProfile(data.profilePhoto),
      //                             SizedBox(height: 25),
      //                             Row(
      //                               children: [
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       // => videoController.likeVideo(data.id),
      //                                       child: Icon(Icons.favorite, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.likes.length.toString(),
      //                                     //   '271',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
      //                                     // ),
      //                                   ],
      //                                 ),
      //                                 SizedBox(width: 20),
      //                                 Column(
      //                                   children: [
      //                                     InkWell(onTap: () {}, child: Icon(Icons.mode_comment_rounded, size: 30, color: Colors.white12,),),
      //                                     // Text(
      //                                     //   // data.commentCount.toString(),
      //                                     //   '29',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
      //                                     // ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 25),
      //                             Row(
      //                               children: [
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       child: Icon(Icons.reply, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.shareCount.toString(),
      //                                     //   '2',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
      //                                   ],
      //                                 ),
      //                                 SizedBox(width: 20),
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       child: Icon(Icons.download, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.shareCount.toString(),
      //                                     //   '2',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 20),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             // Center(
      //             //   child: CircularProgressIndicator(),
      //             // ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.all(10),
      //         padding: const EdgeInsets.all(15),
      //         width: size.width - 20,
      //         height: size.height,
      //         decoration: BoxDecoration(
      //             color: context.theme.appBarColor,
      //             // color: context.theme.bgColor,
      //             borderRadius: BorderRadius.circular(20),
      //             boxShadow: [BoxShadow(
      //               blurRadius: 1.0,
      //               offset: Offset(0.8, 0.5),
      //               color: Colors.black54,
      //             )]
      //         ),
      //         child: Stack(
      //           children: [
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 const SizedBox(height: 15),
      //                 Container(
      //                   width: 120,
      //                   height: 30,
      //                   color: Colors.white12,
      //                 ),
      //                 SizedBox(height: 5),
      //                 Container(
      //                   width: 110,
      //                   height: 18,
      //                   color: Colors.white12,
      //                 ),
      //                 Container(
      //                   height: 50,
      //                   width: double.infinity,
      //                   // color: Colors.white10,
      //                 ),
      //                 Expanded(
      //                   child: Row(
      //                     mainAxisSize: MainAxisSize.max,
      //                     crossAxisAlignment: CrossAxisAlignment.end,
      //                     children: [
      //                       Expanded(
      //                         child: Container(
      //                           padding: const EdgeInsets.only(left: 10),
      //                           child: Column(
      //                             mainAxisSize: MainAxisSize.min,
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                             children: [
      //                               Row(
      //                                 children: [
      //                                   CircleAvatar(
      //                                     radius: 20,
      //                                     backgroundColor: Colors.white12,
      //                                   ),
      //                                   SizedBox(width: 5),
      //                                   Container(
      //                                     width: 80,
      //                                     height: 25,
      //                                     color: Colors.white12,
      //                                   ),
      //                                 ],
      //                               ),
      //                               SizedBox(height: 5),
      //                               Container(
      //                                 width: 120,
      //                                 height: 15,
      //                                 color: Colors.white12,
      //                               ),
      //                               SizedBox(height: 5),
      //                               Container(
      //                                 width: 120,
      //                                 height: 15,
      //                                 color: Colors.white12,
      //                               ),
      //                               SizedBox(height: 25),
      //                               // Row(
      //                               //   children: [
      //                               //     Container(
      //                               //       height: 50,
      //                               //       width: 50,
      //                               //       decoration: BoxDecoration(
      //                               //         color: Colors.grey[100],
      //                               //         borderRadius: BorderRadius.circular(25)
      //                               //       )
      //                               //     ),
      //                               //     SizedBox(width: 5),
      //                               //     Container(
      //                               //       width: 50,
      //                               //       height: 18,
      //                               //       color: Colors.grey[100],
      //                               //     ),
      //                               //   ],
      //                               // ),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         width: 80,
      //                         // margin: EdgeInsets.only(bottom: size.height * .025),
      //                         // color: Colors.black12,
      //                         child: Column(
      //                           mainAxisAlignment: MainAxisAlignment.end,
      //                           children: [
      //                             // buildProfile(data.profilePhoto),
      //                             SizedBox(height: 25),
      //                             Row(
      //                               children: [
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       // => videoController.likeVideo(data.id),
      //                                       child: Icon(Icons.favorite, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.likes.length.toString(),
      //                                     //   '271',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
      //                                     // ),
      //                                   ],
      //                                 ),
      //                                 SizedBox(width: 20),
      //                                 Column(
      //                                   children: [
      //                                     InkWell(onTap: () {}, child: Icon(Icons.mode_comment_rounded, size: 30, color: Colors.white12,),),
      //                                     // Text(
      //                                     //   // data.commentCount.toString(),
      //                                     //   '29',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
      //                                     // ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 25),
      //                             Row(
      //                               children: [
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       child: Icon(Icons.reply, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.shareCount.toString(),
      //                                     //   '2',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
      //                                   ],
      //                                 ),
      //                                 SizedBox(width: 20),
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       child: Icon(Icons.download, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.shareCount.toString(),
      //                                     //   '2',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 20),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             // Center(
      //             //   child: CircularProgressIndicator(),
      //             // ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.all(10),
      //         padding: const EdgeInsets.all(15),
      //         width: size.width - 20,
      //         height: size.height,
      //         decoration: BoxDecoration(
      //             color: context.theme.appBarColor,
      //             // color: context.theme.bgColor,
      //             borderRadius: BorderRadius.circular(20),
      //             boxShadow: [BoxShadow(
      //               blurRadius: 1.0,
      //               offset: Offset(0.8, 0.5),
      //               color: Colors.black54,
      //             )]
      //         ),
      //         child: Stack(
      //           children: [
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 const SizedBox(height: 15),
      //                 Container(
      //                   width: 120,
      //                   height: 30,
      //                   color: Colors.white12,
      //                 ),
      //                 SizedBox(height: 5),
      //                 Container(
      //                   width: 110,
      //                   height: 18,
      //                   color: Colors.white12,
      //                 ),
      //                 Container(
      //                   height: 50,
      //                   width: double.infinity,
      //                   // color: Colors.white10,
      //                 ),
      //                 Expanded(
      //                   child: Row(
      //                     mainAxisSize: MainAxisSize.max,
      //                     crossAxisAlignment: CrossAxisAlignment.end,
      //                     children: [
      //                       Expanded(
      //                         child: Container(
      //                           padding: const EdgeInsets.only(left: 10),
      //                           child: Column(
      //                             mainAxisSize: MainAxisSize.min,
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                             children: [
      //                               Row(
      //                                 children: [
      //                                   CircleAvatar(
      //                                     radius: 20,
      //                                     backgroundColor: Colors.white12,
      //                                   ),
      //                                   SizedBox(width: 5),
      //                                   Container(
      //                                     width: 80,
      //                                     height: 25,
      //                                     color: Colors.white12,
      //                                   ),
      //                                 ],
      //                               ),
      //                               SizedBox(height: 5),
      //                               Container(
      //                                 width: 120,
      //                                 height: 15,
      //                                 color: Colors.white12,
      //                               ),
      //                               SizedBox(height: 5),
      //                               Container(
      //                                 width: 120,
      //                                 height: 15,
      //                                 color: Colors.white12,
      //                               ),
      //                               SizedBox(height: 25),
      //                               // Row(
      //                               //   children: [
      //                               //     Container(
      //                               //       height: 50,
      //                               //       width: 50,
      //                               //       decoration: BoxDecoration(
      //                               //         color: Colors.grey[100],
      //                               //         borderRadius: BorderRadius.circular(25)
      //                               //       )
      //                               //     ),
      //                               //     SizedBox(width: 5),
      //                               //     Container(
      //                               //       width: 50,
      //                               //       height: 18,
      //                               //       color: Colors.grey[100],
      //                               //     ),
      //                               //   ],
      //                               // ),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         width: 80,
      //                         // margin: EdgeInsets.only(bottom: size.height * .025),
      //                         // color: Colors.black12,
      //                         child: Column(
      //                           mainAxisAlignment: MainAxisAlignment.end,
      //                           children: [
      //                             // buildProfile(data.profilePhoto),
      //                             SizedBox(height: 25),
      //                             Row(
      //                               children: [
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       // => videoController.likeVideo(data.id),
      //                                       child: Icon(Icons.favorite, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.likes.length.toString(),
      //                                     //   '271',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
      //                                     // ),
      //                                   ],
      //                                 ),
      //                                 SizedBox(width: 20),
      //                                 Column(
      //                                   children: [
      //                                     InkWell(onTap: () {}, child: Icon(Icons.mode_comment_rounded, size: 30, color: Colors.white12,),),
      //                                     // Text(
      //                                     //   // data.commentCount.toString(),
      //                                     //   '29',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
      //                                     // ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 25),
      //                             Row(
      //                               children: [
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       child: Icon(Icons.reply, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.shareCount.toString(),
      //                                     //   '2',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
      //                                   ],
      //                                 ),
      //                                 SizedBox(width: 20),
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       child: Icon(Icons.download, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.shareCount.toString(),
      //                                     //   '2',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 20),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             // Center(
      //             //   child: CircularProgressIndicator(),
      //             // ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.all(10),
      //         padding: const EdgeInsets.all(15),
      //         width: size.width - 20,
      //         height: size.height,
      //         decoration: BoxDecoration(
      //             color: context.theme.appBarColor,
      //             // color: context.theme.bgColor,
      //             borderRadius: BorderRadius.circular(20),
      //             boxShadow: [BoxShadow(
      //               blurRadius: 1.0,
      //               offset: Offset(0.8, 0.5),
      //               color: Colors.black54,
      //             )]
      //         ),
      //         child: Stack(
      //           children: [
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 const SizedBox(height: 15),
      //                 Container(
      //                   width: 120,
      //                   height: 30,
      //                   color: Colors.white12,
      //                 ),
      //                 SizedBox(height: 5),
      //                 Container(
      //                   width: 110,
      //                   height: 18,
      //                   color: Colors.white12,
      //                 ),
      //                 Container(
      //                   height: 50,
      //                   width: double.infinity,
      //                   // color: Colors.white10,
      //                 ),
      //                 Expanded(
      //                   child: Row(
      //                     mainAxisSize: MainAxisSize.max,
      //                     crossAxisAlignment: CrossAxisAlignment.end,
      //                     children: [
      //                       Expanded(
      //                         child: Container(
      //                           padding: const EdgeInsets.only(left: 10),
      //                           child: Column(
      //                             mainAxisSize: MainAxisSize.min,
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                             children: [
      //                               Row(
      //                                 children: [
      //                                   CircleAvatar(
      //                                     radius: 20,
      //                                     backgroundColor: Colors.white12,
      //                                   ),
      //                                   SizedBox(width: 5),
      //                                   Container(
      //                                     width: 80,
      //                                     height: 25,
      //                                     color: Colors.white12,
      //                                   ),
      //                                 ],
      //                               ),
      //                               SizedBox(height: 5),
      //                               Container(
      //                                 width: 120,
      //                                 height: 15,
      //                                 color: Colors.white12,
      //                               ),
      //                               SizedBox(height: 5),
      //                               Container(
      //                                 width: 120,
      //                                 height: 15,
      //                                 color: Colors.white12,
      //                               ),
      //                               SizedBox(height: 25),
      //                               // Row(
      //                               //   children: [
      //                               //     Container(
      //                               //       height: 50,
      //                               //       width: 50,
      //                               //       decoration: BoxDecoration(
      //                               //         color: Colors.grey[100],
      //                               //         borderRadius: BorderRadius.circular(25)
      //                               //       )
      //                               //     ),
      //                               //     SizedBox(width: 5),
      //                               //     Container(
      //                               //       width: 50,
      //                               //       height: 18,
      //                               //       color: Colors.grey[100],
      //                               //     ),
      //                               //   ],
      //                               // ),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         width: 80,
      //                         // margin: EdgeInsets.only(bottom: size.height * .025),
      //                         // color: Colors.black12,
      //                         child: Column(
      //                           mainAxisAlignment: MainAxisAlignment.end,
      //                           children: [
      //                             // buildProfile(data.profilePhoto),
      //                             SizedBox(height: 25),
      //                             Row(
      //                               children: [
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       // => videoController.likeVideo(data.id),
      //                                       child: Icon(Icons.favorite, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.likes.length.toString(),
      //                                     //   '271',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
      //                                     // ),
      //                                   ],
      //                                 ),
      //                                 SizedBox(width: 20),
      //                                 Column(
      //                                   children: [
      //                                     InkWell(onTap: () {}, child: Icon(Icons.mode_comment_rounded, size: 30, color: Colors.white12,),),
      //                                     // Text(
      //                                     //   // data.commentCount.toString(),
      //                                     //   '29',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
      //                                     // ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 25),
      //                             Row(
      //                               children: [
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       child: Icon(Icons.reply, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.shareCount.toString(),
      //                                     //   '2',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
      //                                   ],
      //                                 ),
      //                                 SizedBox(width: 20),
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       child: Icon(Icons.download, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.shareCount.toString(),
      //                                     //   '2',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 20),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             // Center(
      //             //   child: CircularProgressIndicator(),
      //             // ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.all(10),
      //         padding: const EdgeInsets.all(15),
      //         width: size.width - 20,
      //         height: size.height,
      //         decoration: BoxDecoration(
      //             color: context.theme.appBarColor,
      //             // color: context.theme.bgColor,
      //             borderRadius: BorderRadius.circular(20),
      //             boxShadow: [BoxShadow(
      //               blurRadius: 1.0,
      //               offset: Offset(0.8, 0.5),
      //               color: Colors.black54,
      //             )]
      //         ),
      //         child: Stack(
      //           children: [
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 const SizedBox(height: 15),
      //                 Container(
      //                   width: 120,
      //                   height: 30,
      //                   color: Colors.white12,
      //                 ),
      //                 SizedBox(height: 5),
      //                 Container(
      //                   width: 110,
      //                   height: 18,
      //                   color: Colors.white12,
      //                 ),
      //                 Container(
      //                   height: 50,
      //                   width: double.infinity,
      //                   // color: Colors.white10,
      //                 ),
      //                 Expanded(
      //                   child: Row(
      //                     mainAxisSize: MainAxisSize.max,
      //                     crossAxisAlignment: CrossAxisAlignment.end,
      //                     children: [
      //                       Expanded(
      //                         child: Container(
      //                           padding: const EdgeInsets.only(left: 10),
      //                           child: Column(
      //                             mainAxisSize: MainAxisSize.min,
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                             children: [
      //                               Row(
      //                                 children: [
      //                                   CircleAvatar(
      //                                     radius: 20,
      //                                     backgroundColor: Colors.white12,
      //                                   ),
      //                                   SizedBox(width: 5),
      //                                   Container(
      //                                     width: 80,
      //                                     height: 25,
      //                                     color: Colors.white12,
      //                                   ),
      //                                 ],
      //                               ),
      //                               SizedBox(height: 5),
      //                               Container(
      //                                 width: 120,
      //                                 height: 15,
      //                                 color: Colors.white12,
      //                               ),
      //                               SizedBox(height: 5),
      //                               Container(
      //                                 width: 120,
      //                                 height: 15,
      //                                 color: Colors.white12,
      //                               ),
      //                               SizedBox(height: 25),
      //                               // Row(
      //                               //   children: [
      //                               //     Container(
      //                               //       height: 50,
      //                               //       width: 50,
      //                               //       decoration: BoxDecoration(
      //                               //         color: Colors.grey[100],
      //                               //         borderRadius: BorderRadius.circular(25)
      //                               //       )
      //                               //     ),
      //                               //     SizedBox(width: 5),
      //                               //     Container(
      //                               //       width: 50,
      //                               //       height: 18,
      //                               //       color: Colors.grey[100],
      //                               //     ),
      //                               //   ],
      //                               // ),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         width: 80,
      //                         // margin: EdgeInsets.only(bottom: size.height * .025),
      //                         // color: Colors.black12,
      //                         child: Column(
      //                           mainAxisAlignment: MainAxisAlignment.end,
      //                           children: [
      //                             // buildProfile(data.profilePhoto),
      //                             SizedBox(height: 25),
      //                             Row(
      //                               children: [
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       // => videoController.likeVideo(data.id),
      //                                       child: Icon(Icons.favorite, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.likes.length.toString(),
      //                                     //   '271',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
      //                                     // ),
      //                                   ],
      //                                 ),
      //                                 SizedBox(width: 20),
      //                                 Column(
      //                                   children: [
      //                                     InkWell(onTap: () {}, child: Icon(Icons.mode_comment_rounded, size: 30, color: Colors.white12,),),
      //                                     // Text(
      //                                     //   // data.commentCount.toString(),
      //                                     //   '29',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
      //                                     // ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 25),
      //                             Row(
      //                               children: [
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       child: Icon(Icons.reply, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.shareCount.toString(),
      //                                     //   '2',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
      //                                   ],
      //                                 ),
      //                                 SizedBox(width: 20),
      //                                 Column(
      //                                   children: [
      //                                     InkWell(
      //                                       onTap: () {},
      //                                       child: Icon(Icons.download, size: 30, color: Colors.white12,),
      //                                     ),
      //                                     // Text(
      //                                     //   // data.shareCount.toString(),
      //                                     //   '2',
      //                                     //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 20),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             // Center(
      //             //   child: CircularProgressIndicator(),
      //             // ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.all(10),
      //         padding: const EdgeInsets.all(15),
      //         width: size.width - 20,
      //         height: size.height,
      //         decoration: BoxDecoration(
      //             color: context.theme.appBarColor,
      //             // color: context.theme.bgColor,
      //             borderRadius: BorderRadius.circular(20),
      //             boxShadow: [BoxShadow(
      //               blurRadius: 1.0,
      //               offset: Offset(0.8, 0.5),
      //               color: Colors.black54,
      //             )]
      //         ),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             const SizedBox(height: 15),
      //             Container(
      //               width: double.infinity,
      //               height: 50,
      //               color: Color(0xFFFFFFDD),
      //             ),
      //             SizedBox(height: 2),
      //             Container(
      //               width: double.infinity,
      //               height: 50,
      //               color: Colors.white,
      //               child: Expanded(
      //                   child: Container(color: Colors.orange   .withValues(alpha:.20))
      //               ),
      //             ),
      //             SizedBox(height: 2),
      //             Container(
      //               height: 50,
      //               width: double.infinity,
      //               color: Color(0xFFFBECB2),
      //             ),
      //             SizedBox(height: 2),
      //             Container(
      //               height: 50,
      //               width: double.infinity,
      //               color: Color(0xFFF5E8C7),
      //             ),
      //             SizedBox(height: 2),
      //             Container(
      //               height: 50,
      //               width: double.infinity,
      //               color: Color(0xFFFFEED9),
      //             ),
      //             SizedBox(height: 2),
      //             Container(
      //               height: 50,
      //               width: double.infinity,
      //               color: Color(0xFFF5EEC8),
      //             ),
      //           ],
      //         ),
      //       ),
      //       // buildPostContainer('assets/images/unsplash.jpg'),
      //     ]
      // ),
    );
  }
}
