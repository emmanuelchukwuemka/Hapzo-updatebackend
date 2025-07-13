import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  buildProfile(String profilePhoto) {
    return SizedBox(
        width: 60,
        height: 60,
        child: Stack(children: [
          Positioned(
            left: 5,
            child: Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image(
                        image: NetworkImage(profilePhoto), fit: BoxFit.cover))),
          )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: const AppText(
              text: '  HapzText',
              color: Colors.white,
              fontWeight: FontWeight.bold),
          // backgroundColor: context.theme.appBarColor,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  //  context.read<HomeCubit>()
                  context.push(RouteName.bottomNav.path);
                },
                icon: const Icon(Icons.chat),
                iconSize: 22,
                color: context.theme.primaryColor),
            const SizedBox(width: 3),
            IconButton(
                onPressed: () {
                  context.read<HomeCubit>().fetchPosts();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => const Notifications(),
                  //   ),
                  // );
                },
                icon: const Icon(Icons.notifications),
                iconSize: 22),
            const SizedBox(width: 5),
          ],
          flexibleSpace: ClipPath(
            // clipper: MyCustomClipperForAppBar(),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFC203),
                    Color(0xFFFD8502),
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
          ),
        ),
      ),
      body: PageView(scrollDirection: Axis.vertical, children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          width: size.width - 20,
          height: size.height,
          decoration: BoxDecoration(
              color: context.theme.appBarColor,
              // color: context.theme.bgColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 1.0,
                  offset: Offset(0.8, 0.5),
                  color: Colors.black54,
                )
              ]),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Container(
                    width: 120,
                    height: 30,
                    color: Colors.white12,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 110,
                    height: 18,
                    color: Colors.white12,
                  ),
                  const SizedBox(
                    height: 50,
                    width: double.infinity,
                    // color: Colors.white10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white12,
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      width: 80,
                                      height: 25,
                                      color: Colors.white12,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 120,
                                  height: 15,
                                  color: Colors.white12,
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 120,
                                  height: 15,
                                  color: Colors.white12,
                                ),
                                const SizedBox(height: 25),
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
                        ),
                        SizedBox(
                          width: 80,
                          // margin: EdgeInsets.only(bottom: size.height * .025),
                          // color: Colors.black12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // buildProfile(data.profilePhoto),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        // => videoController.likeVideo(data.id),
                                        child: const Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.likes.length.toString(),
                                      //   '271',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.mode_comment_rounded,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.commentCount.toString(),
                                      //   '29',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.reply,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.shareCount.toString(),
                                      //   '2',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.download,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.shareCount.toString(),
                                      //   '2',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Center(
              //   child: CircularProgressIndicator(),
              // ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          width: size.width - 20,
          height: size.height,
          decoration: BoxDecoration(
              // color: context.theme.bgColor,
              color: context.theme.appBarColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 1.0,
                  offset: Offset(0.8, 0.5),
                  color: Colors.black54,
                )
              ]),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Container(
                    width: 120,
                    height: 30,
                    color: Colors.white12,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 110,
                    height: 18,
                    color: Colors.white12,
                  ),
                  const SizedBox(
                    height: 50,
                    width: double.infinity,
                    // color: Colors.white10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white12,
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      width: 80,
                                      height: 25,
                                      color: Colors.white12,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 120,
                                  height: 15,
                                  color: Colors.white12,
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 120,
                                  height: 15,
                                  color: Colors.white12,
                                ),
                                const SizedBox(height: 25),
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
                        ),
                        SizedBox(
                          width: 80,
                          // margin: EdgeInsets.only(bottom: size.height * .025),
                          // color: Colors.black12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // buildProfile(data.profilePhoto),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        // => videoController.likeVideo(data.id),
                                        child: const Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.likes.length.toString(),
                                      //   '271',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.mode_comment_rounded,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      Text(
                                        // data.commentCount.toString(),
                                        '29',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[100],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.reply,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.shareCount.toString(),
                                      //   '2',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.download,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.shareCount.toString(),
                                      //   '2',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Center(
              //   child: CircularProgressIndicator(),
              // ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          width: size.width - 20,
          height: size.height,
          decoration: BoxDecoration(
              color: context.theme.appBarColor,
              // color: context.theme.bgColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 1.0,
                  offset: Offset(0.8, 0.5),
                  color: Colors.black54,
                )
              ]),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Container(
                    width: 120,
                    height: 30,
                    color: Colors.white12,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 110,
                    height: 18,
                    color: Colors.white12,
                  ),
                  const SizedBox(
                    height: 50,
                    width: double.infinity,
                    // color: Colors.white10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white12,
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      width: 80,
                                      height: 25,
                                      color: Colors.white12,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 120,
                                  height: 15,
                                  color: Colors.white12,
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 120,
                                  height: 15,
                                  color: Colors.white12,
                                ),
                                const SizedBox(height: 25),
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
                        ),
                        SizedBox(
                          width: 80,
                          // margin: EdgeInsets.only(bottom: size.height * .025),
                          // color: Colors.black12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // buildProfile(data.profilePhoto),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        // => videoController.likeVideo(data.id),
                                        child: const Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.likes.length.toString(),
                                      //   '271',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.mode_comment_rounded,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.commentCount.toString(),
                                      //   '29',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.reply,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.shareCount.toString(),
                                      //   '2',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.download,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.shareCount.toString(),
                                      //   '2',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Center(
              //   child: CircularProgressIndicator(),
              // ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          width: size.width - 20,
          height: size.height,
          decoration: BoxDecoration(
              color: context.theme.appBarColor,
              // color: context.theme.bgColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 1.0,
                  offset: Offset(0.8, 0.5),
                  color: Colors.black54,
                )
              ]),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Container(
                    width: 120,
                    height: 30,
                    color: Colors.white12,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 110,
                    height: 18,
                    color: Colors.white12,
                  ),
                  const SizedBox(
                    height: 50,
                    width: double.infinity,
                    // color: Colors.white10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white12,
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      width: 80,
                                      height: 25,
                                      color: Colors.white12,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 120,
                                  height: 15,
                                  color: Colors.white12,
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 120,
                                  height: 15,
                                  color: Colors.white12,
                                ),
                                const SizedBox(height: 25),
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
                        ),
                        SizedBox(
                          width: 80,
                          // margin: EdgeInsets.only(bottom: size.height * .025),
                          // color: Colors.black12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // buildProfile(data.profilePhoto),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        // => videoController.likeVideo(data.id),
                                        child: const Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.likes.length.toString(),
                                      //   '271',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.mode_comment_rounded,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.commentCount.toString(),
                                      //   '29',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.reply,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.shareCount.toString(),
                                      //   '2',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.download,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.shareCount.toString(),
                                      //   '2',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Center(
              //   child: CircularProgressIndicator(),
              // ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          width: size.width - 20,
          height: size.height,
          decoration: BoxDecoration(
              color: context.theme.appBarColor,
              // color: context.theme.bgColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 1.0,
                  offset: Offset(0.8, 0.5),
                  color: Colors.black54,
                )
              ]),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Container(
                    width: 120,
                    height: 30,
                    color: Colors.white12,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 110,
                    height: 18,
                    color: Colors.white12,
                  ),
                  const SizedBox(
                    height: 50,
                    width: double.infinity,
                    // color: Colors.white10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white12,
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      width: 80,
                                      height: 25,
                                      color: Colors.white12,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 120,
                                  height: 15,
                                  color: Colors.white12,
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 120,
                                  height: 15,
                                  color: Colors.white12,
                                ),
                                const SizedBox(height: 25),
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
                        ),
                        SizedBox(
                          width: 80,
                          // margin: EdgeInsets.only(bottom: size.height * .025),
                          // color: Colors.black12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // buildProfile(data.profilePhoto),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        // => videoController.likeVideo(data.id),
                                        child: const Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.likes.length.toString(),
                                      //   '271',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.mode_comment_rounded,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.commentCount.toString(),
                                      //   '29',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.reply,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.shareCount.toString(),
                                      //   '2',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.download,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.shareCount.toString(),
                                      //   '2',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Center(
              //   child: CircularProgressIndicator(),
              // ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          width: size.width - 20,
          height: size.height,
          decoration: BoxDecoration(
              color: context.theme.appBarColor,
              // color: context.theme.bgColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 1.0,
                  offset: Offset(0.8, 0.5),
                  color: Colors.black54,
                )
              ]),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Container(
                    width: 120,
                    height: 30,
                    color: Colors.white12,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 110,
                    height: 18,
                    color: Colors.white12,
                  ),
                  const SizedBox(
                    height: 50,
                    width: double.infinity,
                    // color: Colors.white10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white12,
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      width: 80,
                                      height: 25,
                                      color: Colors.white12,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 120,
                                  height: 15,
                                  color: Colors.white12,
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 120,
                                  height: 15,
                                  color: Colors.white12,
                                ),
                                const SizedBox(height: 25),
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
                        ),
                        SizedBox(
                          width: 80,
                          // margin: EdgeInsets.only(bottom: size.height * .025),
                          // color: Colors.black12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // buildProfile(data.profilePhoto),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        // => videoController.likeVideo(data.id),
                                        child: const Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.likes.length.toString(),
                                      //   '271',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.mode_comment_rounded,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.commentCount.toString(),
                                      //   '29',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.reply,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.shareCount.toString(),
                                      //   '2',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.download,
                                          size: 30,
                                          color: Colors.white12,
                                        ),
                                      ),
                                      // Text(
                                      //   // data.shareCount.toString(),
                                      //   '2',
                                      //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Center(
              //   child: CircularProgressIndicator(),
              // ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          width: size.width - 20,
          height: size.height,
          decoration: BoxDecoration(
              color: context.theme.appBarColor,
              // color: context.theme.bgColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 1.0,
                  offset: Offset(0.8, 0.5),
                  color: Colors.black54,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 50,
                color: const Color(0xFFFFFFDD),
              ),
              const SizedBox(height: 2),
              Container(
                width: double.infinity,
                height: 50,
                color: Colors.white,
                child: Expanded(
                    child:
                        Container(color: Colors.orange.withValues(alpha: .20))),
              ),
              const SizedBox(height: 2),
              Container(
                height: 50,
                width: double.infinity,
                color: const Color(0xFFFBECB2),
              ),
              const SizedBox(height: 2),
              Container(
                height: 50,
                width: double.infinity,
                color: const Color(0xFFF5E8C7),
              ),
              const SizedBox(height: 2),
              Container(
                height: 50,
                width: double.infinity,
                color: const Color(0xFFFFEED9),
              ),
              const SizedBox(height: 2),
              Container(
                height: 50,
                width: double.infinity,
                color: const Color(0xFFF5EEC8),
              ),
            ],
          ),
        ),
        // buildPostContainer('assets/images/unsplash.jpg'),
      ]),
    );
    // FutureBuilder(
    //   future: videoController.listFiles(),
    //   builder: (context, snapshot) {
    //     if(snapshot.connectionState==ConnectionState.waiting && !snapshot.hasData) {
    //       // return Center(child: CircularProgressIndicator(),);
    //       return Container();
    //     }
    //     else if (snapshot.hasData) {
    //       return ListView.builder(
    //         itemCount: snapshot.data!.items.length,
    //         itemBuilder: (context, index) {
    //           return ListTile(
    //             title: Text(snapshot.data!.items[index].name, style: TextStyle(color: Colors.orange,),),
    //             leading: Icon(Icons.video_camera_back_rounded, color: Colors.orange,),
    //           );
    //         },
    //       );
    //     }
    //     return Center(child: Text('Some error occurred'),);p
    //   },
    // ),
  }
  //  Obx(() {
  //  if (videoController.videoList.isEmpty) {
  //    return Container(
  //      margin: const EdgeInsets.all(10),
  //      padding: const EdgeInsets.all(15),
  //      width: size.width - 20,
  //      height: size.height,
  //      decoration: BoxDecoration(
  //        color: Colors.white,
  //        borderRadius: BorderRadius.circular(20),
  //        boxShadow: [BoxShadow(
  //          blurRadius: 1.0,
  //          offset: Offset(0.8, 0.5),
  //          color: Colors.black54,
  //        )]
  //      ),
  //      child: Stack(
  //        children: [
  //          Column(
  //            crossAxisAlignment: CrossAxisAlignment.start,
  //            children: [
  //              const SizedBox(height: 15),
  //              Container(
  //                width: 120,
  //                height: 30,
  //                color: Colors.grey[100],
  //              ),
  //              SizedBox(height: 5),
  //              Container(
  //                width: 110,
  //                height: 18,
  //                color: Colors.grey[100],
  //              ),
  //              Container(
  //                height: 50,
  //                width: double.infinity,
  //                color: Colors.white10,
  //              ),
  //              Expanded(
  //                child: Row(
  //                  mainAxisSize: MainAxisSize.max,
  //                  crossAxisAlignment: CrossAxisAlignment.end,
  //                  children: [
  //                    Expanded(
  //                      child: Container(
  //                        padding: const EdgeInsets.only(left: 10),
  //                        child: Column(
  //                          mainAxisSize: MainAxisSize.min,
  //                          crossAxisAlignment: CrossAxisAlignment.start,
  //                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                          children: [
  //                            Row(
  //                              children: [
  //                                CircleAvatar(
  //                                  radius: 20,
  //                                  backgroundColor: Colors.grey[100],
  //                                ),
  //                                SizedBox(width: 5),
  //                                Container(
  //                                  width: 80,
  //                                  height: 25,
  //                                  color: Colors.grey[100],
  //                                ),
  //                              ],
  //                            ),
  //                            SizedBox(height: 5),
  //                            Container(
  //                              width: 120,
  //                              height: 15,
  //                              color: Colors.grey[100],
  //                            ),
  //                            SizedBox(height: 5),
  //                            Container(
  //                              width: 120,
  //                              height: 15,
  //                              color: Colors.grey[100],
  //                            ),
  //                            SizedBox(height: 25),
  //                            // Row(
  //                            //   children: [
  //                            //     Container(
  //                            //       height: 50,
  //                            //       width: 50,
  //                            //       decoration: BoxDecoration(
  //                            //         color: Colors.grey[100],
  //                            //         borderRadius: BorderRadius.circular(25)
  //                            //       )
  //                            //     ),
  //                            //     SizedBox(width: 5),
  //                            //     Container(
  //                            //       width: 50,
  //                            //       height: 18,
  //                            //       color: Colors.grey[100],
  //                            //     ),
  //                            //   ],
  //                            // ),
  //                          ],
  //                        ),
  //                      ),
  //                    ),
  //                    Container(
  //                      width: 80,
  //                      margin: EdgeInsets.only(top: size.height/6),
  //                      // color: Colors.black12,
  //                      child: Column(
  //                        mainAxisAlignment: MainAxisAlignment.center,
  //                        children: [
  //                          // buildProfile(data.profilePhoto),
  //                          SizedBox(height: 25),
  //                          InkWell(
  //                            onTap: () {},
  //    // => videoController.likeVideo(data.id),
  //                            child: Icon(Icons.favorite, size: 30, color: Colors.grey[100],),
  //                          ),
  //                          // Text(
  //                          //   // data.likes.length.toString(),
  //                          //   '271',
  //                          //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
  //                          // ),
  //                          SizedBox(height: 25),
  //                          InkWell(onTap: () {}, child: Icon(Icons.mode_comment_rounded, size: 30, color: Colors.grey[100],),),
  //                          // Text(
  //                          //   // data.commentCount.toString(),
  //                          //   '29',
  //                          //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),
  //                          // ),
  //                          SizedBox(height: 25),
  //                          InkWell(onTap: () {}, child: Icon(Icons.reply, size: 30, color: Colors.grey[100],),),
  //                          SizedBox(height: 25),
  //                          InkWell(onTap: () {}, child: Icon(Icons.download, size: 30, color: Colors.grey[100],),),
  //                          // Text(
  //                          //   // data.shareCount.toString(),
  //                          //   '2',
  //                          //   style: TextStyle(fontSize: 15, color: Colors.grey[100],),),
  //                          SizedBox(height: 15),
  //                        ],
  //                      ),
  //                    ),
  //                  ],
  //                ),
  //              ),
  //            ],
  //          ),
  //          // Center(
  //          //   child: CircularProgressIndicator(),
  //          // ),
  //        ],
  //      ),
  //    );
  //  } else {
  //    return PageView.builder(
  //    itemCount: videoController.videoList.length,
  //    // itemCount: 10,
  //    controller: PageController(initialPage: 0, viewportFraction: 1),
  //    scrollDirection: Axis.vertical,
  //    itemBuilder: (context, index) {
  //      final data = videoController.videoList[index];
  //      return Container(
  //        margin: const EdgeInsets.all(10),
  //        padding: const EdgeInsets.all(15),
  //        width: size.width - 20,
  //        height: size.height * .75,
  //        decoration: BoxDecoration(
  //          color: Colors.white,
  //          borderRadius: BorderRadius.circular(15),
  //        ),
  //        child: Stack(
  //          children: [
  //            PostItem(videoUrl: data.videoUrl,),
  //            Column(
  //              children: [
  //                Row(
  //                  children: [
  //                    CircleAvatar(
  //                      radius: 30,
  //                      backgroundImage: AssetImage('assets/images/me.jpg'),
  //                    ),
  //                    // buildProfile(data.profilePhoto),
  //                    SizedBox(width: 10),
  //                    Column(
  //                      crossAxisAlignment: CrossAxisAlignment.start,
  //                      children: [
  //                        Text('Fortune', style: TextStyle(color: Colors.orange,
  //                            fontSize: 15,
  //                            fontWeight: FontWeight.bold,),),
  //                        Text('52 mins ago',
  //                            style: TextStyle(color: Colors.orange, fontSize: 12,),),
  //                      ],
  //                    ),
  //                  ],
  //                ),
  //                Container(
  //                  height: 50,
  //                  width: double.infinity,
  //                  color: Colors.black38,
  //                ),
  //                Expanded(
  //                  child: Row(
  //                    mainAxisSize: MainAxisSize.max,
  //                    crossAxisAlignment: CrossAxisAlignment.end,
  //                    children: [
  //                      Expanded(
  //                        child: Container(
  //                          padding: const EdgeInsets.only(left: 20),
  //                          child: Column(
  //                            mainAxisSize: MainAxisSize.min,
  //                            crossAxisAlignment: CrossAxisAlignment.start,
  //                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                            children: [
  //                              Text(
  //                                data.username,
  //                                // 'Username',
  //                                style: const TextStyle(
  //                                  fontSize: 20,
  //                                  color: Colors.orange,
  //                                  fontWeight: FontWeight.bold,
  //                                ),
  //                              ),
  //                              Text(
  //                                data.caption,
  //                                // 'Caption',
  //                                style: const TextStyle(
  //                                  fontSize: 15,
  //                                  color: Colors.black,
  //                                ),
  //                              ),
  //                              Row(
  //                                children: [
  //                                  const Icon(
  //                                    Icons.music_note,
  //                                    size: 15,
  //                                    color: Colors.black,
  //                                  ),
  //                                  Text(
  //                                    data.title,
  //                                    // 'Title',
  //                                    style: const TextStyle(
  //                                      fontSize: 15,
  //                                      color: Colors.black,
  //                                      fontWeight: FontWeight.bold,
  //                                    ),
  //                                  ),
  //                                ],
  //                              )
  //                            ],
  //                          ),
  //                        ),
  //                      ),
  //                      Container(
  //                        width: 100,
  //                        margin: EdgeInsets.only(top: size.height/55),
  //                        color: Colors.black12,
  //                        child: Column(
  //                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                          children: [
  //                            // buildProfile(data.profilePhoto),
  //                            Column(
  //                              children: [
  //                                InkWell(
  //                                  onTap: () => videoController.likeVideo(data.id),
  //                                  child: Icon(Icons.favorite, size: 30, color: Colors.orange,),
  //                                ),
  //                                Text(
  //                                  data.likes.length.toString(),
  //                                  // '2,200',
  //                                  style: TextStyle(fontSize: 15, color: Colors.orange,),),
  //                                SizedBox(height: 7),
  //                                InkWell(onTap: () {}, child: Icon(Icons.comment, size: 30, color: Colors.orange,),),
  //                                Text(
  //                                  data.commentCount.toString(),
  //                                  // '29',
  //                                  style: TextStyle(fontSize: 15, color: Colors.orange,),),
  //                                SizedBox(height: 7),
  //                                InkWell(onTap: () {}, child: Icon(Icons.reply, size: 30, color: Colors.orange,),),
  //                                Text(
  //                                  // data.shareCount.toString(),
  //                                  '2',
  //                                  style: TextStyle(fontSize: 15, color: Colors.orange,),),
  //                                SizedBox(height: 7),
  //                              ],
  //                            ),
  //                          ],
  //                        ),
  //                      ),
  //                    ],
  //                  ),
  //                ),
  //              ],
  //            )
  //          ],
  //        ),
  //      );
  //    },
  //  );}
  // }),
}
