import 'package:flutter/material.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class PostTab extends StatefulWidget {
  const PostTab({Key? key}) : super(key: key);

  @override
  State<PostTab> createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text(
              'Recents',
              style: TextStyle(color: context.theme.primaryColor, fontSize: 15.0, fontWeight: FontWeight.bold,),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            height: size.height * .22,
            width: size.width,
            decoration: BoxDecoration(
              color: context.theme.bgColor,
              border: Border(
                // top: BorderSide(color: Colors.grey.shade400, width: 0.5),
                bottom: BorderSide(color: context.theme.primaryColor!, width: 0.5,),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Expanded(
                    // width: size.width * .9,
                    // height: size.height * .15,
                    // color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.5),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Fortune', style: TextStyle(color: context.theme.textColor,),),
                                const SizedBox(width: 5),
                                const Text('@paramount . 03 Feb', style: TextStyle(color: Colors.grey,),),
                              ]
                          ),
                          const SizedBox(height: 5),
                          const SizedBox(
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
                    // color: Colors.orange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.favorite_border, color: context.theme.greyColor,),
                            Text('26k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.chat, color: context.theme.greyColor,),
                            Text('5.2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.share, color: context.theme.greyColor,),
                            Text('2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.download, color: context.theme.greyColor,),
                            Text('1.2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            height: size.height * .22,
            width: size.width,
            decoration: BoxDecoration(
              color: context.theme.bgColor,
              border: Border(
                // top: BorderSide(color: Colors.grey.shade400, width: 0.5),
                bottom: BorderSide(color: context.theme.primaryColor!, width: 0.5,),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Expanded(
                    // width: size.width * .9,
                    // height: size.height * .15,
                    // color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.5),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Fortune', style: TextStyle(color: context.theme.textColor,),),
                                SizedBox(width: 5),
                                Text('@paramount . 03 Feb', style: TextStyle(color: Colors.grey,),),
                              ]
                          ),
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
                    // color: Colors.orange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.favorite_border, color: context.theme.greyColor,),
                            Text('26k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.chat, color: context.theme.greyColor,),
                            Text('5.2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.share, color: context.theme.greyColor,),
                            Text('2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.download, color: context.theme.greyColor,),
                            Text('1.2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            height: size.height * .22,
            width: size.width,
            decoration: BoxDecoration(
              color: context.theme.bgColor,
              border: Border(
                // top: BorderSide(color: Colors.grey.shade400, width: 0.5),
                bottom: BorderSide(color: context.theme.primaryColor!, width: 0.5,),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Expanded(
                    // width: size.width * .9,
                    // height: size.height * .15,
                    // color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.5),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Fortune', style: TextStyle(color: context.theme.textColor,),),
                                SizedBox(width: 5),
                                Text('@paramount . 03 Feb', style: TextStyle(color: Colors.grey,),),
                              ]
                          ),
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
                    // color: Colors.orange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.favorite_border, color: context.theme.greyColor,),
                            Text('26k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.chat, color: context.theme.greyColor,),
                            Text('5.2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.share, color: context.theme.greyColor,),
                            Text('2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.download, color: context.theme.greyColor,),
                            Text('1.2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            height: size.height * .22,
            width: size.width,
            decoration: BoxDecoration(
              color: context.theme.bgColor,
              border: Border(
                // top: BorderSide(color: Colors.grey.shade400, width: 0.5),
                bottom: BorderSide(color: context.theme.primaryColor!, width: 0.5,),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Expanded(
                    // width: size.width * .9,
                    // height: size.height * .15,
                    // color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.5),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Fortune', style: TextStyle(color: context.theme.textColor,),),
                                SizedBox(width: 5),
                                Text('@paramount . 03 Feb', style: TextStyle(color: Colors.grey,),),
                              ]
                          ),
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
                    // color: Colors.orange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.favorite_border, color: context.theme.greyColor,),
                            Text('26k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.chat, color: context.theme.greyColor,),
                            Text('5.2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.share, color: context.theme.greyColor,),
                            Text('2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.download, color: context.theme.greyColor,),
                            Text('1.2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            height: size.height * .22,
            width: size.width,
            decoration: BoxDecoration(
              color: context.theme.bgColor,
              border: Border(
                // top: BorderSide(color: Colors.grey.shade400, width: 0.5),
                bottom: BorderSide(color: context.theme.primaryColor!, width: 0.5,),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Expanded(
                    // width: size.width * .9,
                    // height: size.height * .15,
                    // color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.5),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Fortune', style: TextStyle(color: context.theme.textColor,),),
                                SizedBox(width: 5),
                                Text('@paramount . 03 Feb', style: TextStyle(color: Colors.grey,),),
                              ]
                          ),
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
                    // color: Colors.orange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.favorite_border, color: context.theme.greyColor,),
                            Text('26k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.chat, color: context.theme.greyColor,),
                            Text('5.2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.share, color: context.theme.greyColor,),
                            Text('2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.download, color: context.theme.greyColor,),
                            Text('1.2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            height: size.height * .22,
            width: size.width,
            decoration: BoxDecoration(
              color: context.theme.bgColor,
              border: Border(
                // top: BorderSide(color: Colors.grey.shade400, width: 0.5),
                bottom: BorderSide(color: context.theme.primaryColor!, width: 0.5,),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Expanded(
                    // width: size.width * .9,
                    // height: size.height * .15,
                    // color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.5),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Fortune', style: TextStyle(color: context.theme.textColor,),),
                                SizedBox(width: 5),
                                Text('@paramount . 03 Feb', style: TextStyle(color: Colors.grey,),),
                              ]
                          ),
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
                    // color: Colors.orange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.favorite_border, color: context.theme.greyColor,),
                            Text('26k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.chat, color: context.theme.greyColor,),
                            Text('5.2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.share, color: context.theme.greyColor,),
                            Text('2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.download, color: context.theme.greyColor,),
                            Text('1.2k', style: TextStyle(color: context.theme.greyColor,),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}
