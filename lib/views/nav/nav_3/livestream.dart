import 'package:flutter/material.dart'; 
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

import '../../../common/custom_dialog_option.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Live extends StatefulWidget {
  const Live({Key? key}) : super(key: key);

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {

  // Future<dynamic> _showOptionsDialog(BuildContext context) async {
  //   // setState(() {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => SimpleDialog(
  //       // alignment: Alignment.center,
  //       children: [
  //         Text('Name'),
  //         ListView.builder(
  //       itemCount: chats.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           final chat = chats[index];
  //           return Container(
  //             padding: const EdgeInsets.all(10),
  //             child: Row(
  //                 children: [
  //                   CircleAvatar(
  //                     radius: 17.50,
  //                     backgroundImage: AssetImage(chat.sender.imgUrl),
  //                   ),
  //                   SizedBox(width: 15),
  //                   Container(
  //                     width: MediaQuery.of(context).size.width * .5,
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           chat.sender.name,
  //                           style: TextStyle(
  //                             fontSize: 13,
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         Text(
  //                           chat.time,
  //                           style: TextStyle(
  //                             fontSize: 10,
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.w400,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ]
  //             ),
  //           );
  //         },
  //       ),
  //       ]
  //     ),
  //     // SimpleDialog(
  //     //   children: [
  //     //     SimpleDialogOption(
  //     //       onPressed: () {},
  //     //       child: Container(
  //     //         child: Center(
  //     //           child: Text(
  //     //             'This is what you need to know about me... A Mobile Developer with an enthusiasm for knowledge and inventions',
  //     //             style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15, color: context.theme.textColor,),
  //     //             textAlign: TextAlign.center,
  //     //           ),
  //     //         ),
  //     //       ),
  //     //     ),
  //     //   ],
  //     // ),
  //   );
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: AppBar(
          backgroundColor: context.theme.appBarColor,
          leading: Center(child: Text(' LIVE', style: TextStyle(fontWeight: FontWeight.bold, color: context.theme.titleTextColor,),)),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomDialogWidget(trailingIcon: Container(
                                    height: 30,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.5),
                                      color: Colors.orange,
                                    ),
                                    child: const Center(
                                      child: Text('Follow', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
                                    ),
                                  ),),
                                );
                              },
                              icon: Icon(Icons.remove_red_eye, size: 25, color: context.theme.primaryColor,),
                            ),
                            // SizedBox(width: 1.0,),
                            Text('31', style: TextStyle(fontSize: 12, color: context.theme.primaryColor,),)
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => CustomDialogWidget(trailingIcon: Icon(Icons.add, color: context.theme.primaryColor,),),
                            );
                          },
                          icon: Icon(Icons.person_add_alt_1_rounded, size: 22.5, color: context.theme.primaryColor,),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 100, right: 5.0),
                    width: 70,
                    // color: Colors.green,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: context.theme.greyColor,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Icon(
                            Icons.videocam,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: context.theme.greyColor,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Icon(
                            Icons.cameraswitch,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: context.theme.greyColor,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Icon(
                            Icons.volume_up,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: context.theme.greyColor,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Icon(
                            Icons.mic,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: context.theme.greyColor,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Icon(
                            Icons.message,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomLeft,
                //   child: Container(
                //     height: 50,
                //     width: 200,
                //     margin: const EdgeInsets.only(bottom: 15.0, left: 25),
                //     padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0,),
                //     decoration: BoxDecoration(
                //       color: Colors.white24,
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //     child: Text('Comment')
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
