import 'package:flutter/material.dart';
// import 'package:haptext_api/exports.dart';

class Tab3 extends StatefulWidget {
  const Tab3({Key? key}) : super(key: key);

  @override
  State<Tab3> createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: 24,
        itemBuilder: (context, index) => Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              height: size.height * .22,
              width: size.width,
              // decoration: BoxDecoration(
              // color: context.theme.bgColor,
              // border: Border(
              // top: BorderSide(color: Colors.grey.shade400, width: 0.5),
              // bottom: BorderSide(color: context.theme.primaryColor!, width: 0.5),
              // ),
              // ),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Roman',
                                    // style: TextStyle(
                                    //   color: context.theme.textColor,
                                    // ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '@remedy_boy1 . 17 Jul',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ]),
                            SizedBox(height: 5),
                            SizedBox(
                              child: Text(
                                'slhsla;ihdlfhw;oeihr ssfhnskjfsfskjfks skfjskfksfns   sfjbskjfhksherne  skjkfhs ksjfhksf ksjhskjrb fksjs slshfldsjo soalsfnd shdohdof soihfshfsj oshfsiuhsjkfnsd fsukhfkls;lfhs osuhfshf suhfkd fosuhfls oshfoushf shufoshfl siosjfslih sohlsjbvihcis subslnxbv xbv,xnvl sddsf',
                                style: TextStyle(color: Colors.grey),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * .9,
                      height: 45.0,
                      // color: Colors.white70,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.favorite_border,
                                // color: context.theme.greyColor,
                              ),
                              Text(
                                '76',
                                style: TextStyle(
                                  // color: context.theme.greyColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.chat,
                                // color: context.theme.greyColor,
                              ),
                              Text(
                                '17',
                                style: TextStyle(
                                  // color: context.theme.greyColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.share,
                                // color: context.theme.greyColor,
                              ),
                              Text(
                                '5',
                                style: TextStyle(
                                  // color: context.theme.greyColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.download,
                                // color: context.theme.greyColor,
                              ),
                              Text(
                                '1',
                                style: TextStyle(
                                  // color: context.theme.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

// Widget buildText(Size size) {
//   return ListView.builder(
//       itemCount: 24,
//       itemBuilder: (context, index) => Container(
//         padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
//         height: size.height * .22,
//         width: size.width,
//         decoration: BoxDecoration(
//           color: Colors.grey[100],
//           border: Border(
//             // top: BorderSide(color: Colors.grey.shade400, width: 0.5),
//             bottom: BorderSide(color: Colors.orange, width: 0.5),
//           ),
//         ),
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(height: 5),
//               Container(
//                 width: size.width * .9,
//                 height: size.height * .15,
//                 // color: Colors.black12,
//                 child: Column(
//                   children: [
//                     Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text('Roman', style: TextStyle(color: Colors.black,),),
//                           SizedBox(width: 3.5),
//                           Text('@melody_boy1 . 17 Jul', style: TextStyle(color: Colors.grey,),),
//                         ]
//                     ),
//                     SizedBox(height: 3.5),
//                     SizedBox(
//                       child: Text(
//                         'slhsla;ihdlfhw;oeihr ssfhnskjfsfskjfks skfjskfksfns   sfjbskjfhksherne  skjkfhs ksjfhksf ksjhskjrb fksjs slshfldsjo soalsfnd shdohdof soihfshfsj oshfsiuhsjkfnsd fsukhfkls;lfhs osuhfshf suhfkd fosuhfls oshfoushf shufoshfl siosjfslih sohlsjbvihcis subslnxbv xbv,xnvl sddsf',
//                         style: TextStyle(color: Colors.grey),
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: size.width * .9,
//                 height: size.height * .03,
//                 // color: Colors.white70,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.favorite_border, color: Colors.grey,),
//                         Text('76', style: TextStyle(color: Colors.grey,),),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Icon(Icons.chat, color: Colors.grey,),
//                         Text('17', style: TextStyle(color: Colors.grey,),),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Icon(Icons.share, color: Colors.grey,),
//                         Text('5', style: TextStyle(color: Colors.grey,),),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Icon(Icons.download, color: Colors.grey,),
//                         Text('1', style: TextStyle(color: Colors.grey,),),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//   );
// }
