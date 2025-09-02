 

import 'package:haptext_api/exports.dart';

class XploreTab3 extends StatelessWidget {
  const XploreTab3({Key? key}) : super(key: key);

  // final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    // Future showToast(String message) async {
    //   await Fluttertoast.cancel();
    //
    //   Fluttertoast.showToast(msg: message, fontSize: 18,);
    // }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black54,
              child: Stack(children: [
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          'assets/images/asta.jpg',
                        ),
                      ),
                      Text(
                        'Connecting . . .',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      margin: const EdgeInsets.only(top: 25.0, right: 25.0),
                      child: const Icon(
                        // FontAwesomeIcons.expand,
                        Icons.add, color: Colors.white, size: 22.0,
                      )),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: const EdgeInsets.only(top: 25.0, left: 25.0),
                      child: const Icon(
                        Icons.flag,
                        color: Colors.green,
                        size: 30,
                      )),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 1.0),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black54,
              child: const Stack(children: [
                Center(
                  child: CircleAvatar(
                    radius: 55.0,
                    backgroundImage: AssetImage(
                      'assets/images/yuno.jpg',
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: Container(
                //     margin: EdgeInsets.only(bottom: 25.0, right: 25.0),
                //     height: 50,
                //     width: 50,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(25),
                //       boxShadow: [BoxShadow(
                //         blurRadius: 2.0,
                //         offset: Offset(1.0, 1.0),
                //         color: Colors.black87,
                //       )],
                //     ),
                //     child: Center(
                //       child: IconButton(
                //         onPressed: () {
                //           print('Video call menu button clicked');
                //         },
                //         icon: Icon(Icons.add, color: Colors.orange,
                //           size: 30,),
                //       ),
                //     ),
                //   ),
                // ),
              ]),
            ),
          ),
          // Container(
          //   width: size.width,
          //   height: size.height * .55,
          //   margin: const EdgeInsets.all(3.0),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(15),
          //   ),
          //   child: Stack(
          //     children: [
          //       Center(
          //         child: Image(
          //           height: double.infinity,
          //           width: double.infinity,
          //           image: AssetImage('assets/images/sasuke.jpg'),
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text('Fortune', style: TextStyle(color: Colors.orange,
          //                       fontSize: 15,
          //                       fontWeight: FontWeight.bold,),),
          //                     Text('52 mins ago',
          //                       style: TextStyle(color: Colors.orange, fontSize: 12,),),
          //                   ],
          //                 ),
          //                 InkWell(
          //                   onTap: () {
          //                     print('Follow button clicked');
          //                   },
          //                   child: Text(
          //                     'Follow...',
          //                     style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold,),
          //                   ),
          //                 )
          //               ],
          //             ),
          //             Expanded(
          //               child: Row(
          //                 mainAxisSize: MainAxisSize.max,
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 crossAxisAlignment: CrossAxisAlignment.end,
          //                 children: [
          //                   Container(
          //                     width: size.width * .65,
          //                     height: size.height * .15,
          //                     padding: const EdgeInsets.only(left: 10),
          //                     child: Row(
          //                       mainAxisAlignment: MainAxisAlignment.start,
          //                       // crossAxisAlignment: CrossAxisAlignment.center,
          //                       children: [
          //                         CircleAvatar(
          //                           radius: 30,
          //                           backgroundImage: AssetImage('assets/images/me.jpg'),
          //                         ),
          //                         SizedBox(width: 5),
          //                         Column(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             Text(
          //                               'Caption',
          //                               style: const TextStyle(
          //                                 fontSize: 13,
          //                                 color: Colors.orange,
          //                               ),
          //                             ),
          //                             Row(
          //                               children: [
          //                                 const Icon(
          //                                   Icons.music_note,
          //                                   size: 15,
          //                                   color: Colors.orange,
          //                                 ),
          //                                 Text(
          //                                   'Title',
          //                                   style: const TextStyle(
          //                                     fontSize: 13,
          //                                     color: Colors.orange,
          //                                     fontWeight: FontWeight.bold,
          //                                   ),
          //                                 ),
          //                               ],
          //                             )
          //                           ],
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   // Container(
          //                   //   width: 100,
          //                   //   margin: EdgeInsets.only(top: size.height/55),
          //                   //   child: Column(
          //                   //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                   //     children: [
          //                   //       // buildProfile(data.profilePhoto),
          //                   //       Column(
          //                   //         children: [
          //                   //           InkWell(
          //                   //             onTap: () {},
          //                   //             child: Icon(Icons.favorite, size: 30, color: Colors.orange,),
          //                   //           ),
          //                   //           Text(
          //                   //             '2,200',
          //                   //             style: TextStyle(fontSize: 15, color: Colors.orange,),
          //                   //           ),
          //                   //           SizedBox(height: 7),
          //                   //           InkWell(onTap: () {}, child: Icon(Icons.comment, size: 30, color: Colors.orange,),),
          //                   //           Text(
          //                   //             '29',
          //                   //             style: TextStyle(fontSize: 15, color: Colors.orange,),
          //                   //           ),
          //                   //           SizedBox(height: 7),
          //                   //           InkWell(onTap: () {}, child: Icon(Icons.reply, size: 30, color: Colors.orange,),),
          //                   //           Text(
          //                   //             // data.shareCount.toString(),
          //                   //             '2',
          //                   //             style: TextStyle(fontSize: 15, color: Colors.orange,),),
          //                   //           SizedBox(height: 7),
          //                   //         ],
          //                   //       ),
          //                   //     ],
          //                   //   ),
          //                   // ),
          //                   Container(
          //                     width: 80,
          //                     // margin: EdgeInsets.only(top: size.height/8),
          //                     // color: Colors.black12,
          //                     child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         // buildProfile(data.profilePhoto),
          //                         SizedBox(height: 25),
          //                         InkWell(
          //                           onTap: () {},
          //                           child: Icon(Icons.favorite, size: 20, color: Colors.orange,),
          //                         ),
          //                         Text(
          //                           '271',
          //                           style: TextStyle(fontSize: 12, color: Colors.orange,),
          //                         ),
          //                         SizedBox(height: 25),
          //                         InkWell(onTap: () {}, child: Icon(Icons.mode_comment_rounded, size: 20, color: Colors.orange,),),
          //                         Text(
          //                           '29',
          //                           style: TextStyle(fontSize: 12, color: Colors.orange,),
          //                         ),
          //                         SizedBox(height: 25),
          //                         InkWell(onTap: () {}, child: Icon(Icons.reply, size: 20, color: Colors.orange,),),
          //                         Text(
          //                           '2',
          //                           style: TextStyle(fontSize: 12, color: Colors.orange,),
          //                         ),
          //                         SizedBox(height: 25),
          //                         InkWell(onTap: () {}, child: Icon(Icons.download, size: 20, color: Colors.orange,),),
          //                         Text(
          //                           '2',
          //                           style: TextStyle(fontSize: 12, color: Colors.orange,),
          //                         ),
          //                         SizedBox(height: 15),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
      // floatingActionButton: SpeedDial(
      //   animatedIcon: AnimatedIcons.menu_close,
      //   animationDuration: Duration(milliseconds: 400),
      //   backgroundColor: context.theme.primaryColor,
      //   elevation: 6.0,
      //   overlayColor: Colors.black,
      //   overlayOpacity: 0.4,
      //   children: [
      //     SpeedDialChild(
      //       child: Icon(FontAwesomeIcons.thumbsUp),
      //       label: 'Start',
      //       // onTap: () => showToast('Selected github'),
      //     ),
      //     SpeedDialChild(
      //       child: Icon(Icons.mail),
      //       label: 'Message',
      //       // onTap: () => showToast('Selected mail'),
      //     ),
      //     SpeedDialChild(
      //       child: Icon(FontAwesomeIcons.shuffle),
      //       label: 'Shuffle',
      //     ),
      //     SpeedDialChild(
      //       child: Icon(Icons.videocam_off_outlined),
      //       label: 'Video',
      //       // onTap: () => showToast('Selected share'),
      //     ),
      //     SpeedDialChild(
      //       child: Icon(Icons.mic_off),
      //       label: 'Mic',
      //       // onTap: () => showToast('Selected twitter'),
      //     ),
      //     // SpeedDialChild(
      //     //   child: Icon(Icons.copy),
      //     //   label: 'Copy',
      //     //   // onTap: () => showToast('Selected copy'),
      //     // ),
      //     // SpeedDialChild(
      //     //   child: Icon(FontAwesomeIcons.linkedin),
      //       // label: 'Share',
      //       // onTap: () => showToast('Selected linkedin'),
      //     // ),
      //   ]
      // ),
    );
  }
}
