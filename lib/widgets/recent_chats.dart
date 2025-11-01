// import 'package:flutter/material.dart';
// import 'package:haptext_api/exports.dart';
// import 'package:haptext_api/common/theme/custom_theme_extension.dart';

// class RecentChats extends StatefulWidget {
//   const RecentChats({Key? key}) : super(key: key);

//   @override
//   State<RecentChats> createState() => _RecentChatsState();
// }

// class _RecentChatsState extends State<RecentChats> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: context.theme.bgColor,
//         child: ListView.builder(
//           itemCount: chats.length,
//           itemBuilder: (BuildContext context, int index) {
//             final chat = chats[index];
//             return Container(
//               margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5.0),
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5.0),
//               // decoration: BoxDecoration(
//                 // color: chat.unread ? const Color(0xFFFFEFEE) : context.theme.readMessageColor,
//                 // borderRadius: const BorderRadius.only(
//                 //   topRight: Radius.circular(20),
//                 //   bottomRight: Radius.circular(20),
//                 // ),
//               // ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 25.0,
//                         backgroundImage: AssetImage(chat.sender.imgUrl),
//                       ),
//                       SizedBox(width: 12),
//                       Container(
//                         width: MediaQuery.of(context).size.width * .5,
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(user: chat.sender),),);
//                           },
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 chat.sender.name,
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Color(0xFFFFEED9),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 5),
//                               Text(
//                                 chat.text,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: context.theme.greyColor,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ]
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         chat.time,
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: context.theme.greyColor,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       SizedBox(height: 7.5),
//                       Container(
//                         width: 20,
//                         height: 20,
//                         decoration: BoxDecoration(
//                           color: Color(0xFFFFEED9),
//                           borderRadius: BorderRadius.circular(10)
//                         ),
//                         alignment: Alignment.center,
//                         child: Text(
//                           '6',
//                           style: TextStyle(
//                             fontSize: 11,
//                             letterSpacing: 0.5,
//                             color: context.theme.greyColor,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }
//         ),
//       ),
//     );
//   }
// }
