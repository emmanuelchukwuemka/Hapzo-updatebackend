import 'package:haptext_api/exports.dart';
import 'package:haptext_api/views/nav/exports.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile-screen';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  // Widget _buildIcon(int index, IconData icon, Widget page) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         _selectedIndex = index;
  //       });
  //     },
  //     child: Container(
  //       height: 50,
  //       width: 50,
  //       child: IconButton(
  //         icon: Icon(icon),
  //         onPressed: () {
  //           Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  //         },
  //         iconSize: 25.0,
  //         color: _selectedIndex == index ? Colors.orange : Colors.grey,
  //       ),
  //     ),
  //   );
  // }

  // UserController _userController = Get.put(UserController());
  int current = 0;
  late TabController tabController;
  UserModel? _userData;
  UserModel? newData;

  // Future<void> fetchUserData() async {
  //   isLoading = true;
  //   final prefs = await SharedPreferences.getInstance();
  //   final userId = prefs.getString('savedUserId');
  //   final profileID = prefs.getString('savedProfile_id');
  //   final token = prefs.getString('savedToken');
  //   final userName = prefs.getString('savedUsername');
  //
  //   setState(() {
  //     _userData = UserModel(id: userId!, tagname: userName!, token: token, user: profileID,);
  //     isLoading = false;
  //   });
  // }
  Future<void> getData() async {
    setState(() {});
  }

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
    getData();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<dynamic> _showOptionsDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () {},
            child: const Center(
              child: Text(
                'This is what you need to know about me... A Mobile Developer with an enthusiasm for knowledge and inventions',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  // color: context.theme.textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> items = [
    "Pictures",
    "Videos",
    "Texts",
    "Audios",
    "Downloads",
  ];

  List<Widget> tabss = [
    const Tab1(),
    const Tab2(),
    const Tab3(),
    const Tab4(),
    const Tab5(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // iconTheme: const IconThemeData(
          //     color: context.theme.primaryColor,
          //     ),
          title: const Text(
            '  Profile',
            style: TextStyle(
              // color: context.theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          // backgroundColor: context.theme.appBarColor,
          elevation: 0,
          actions: [
            const Icon(
              Icons.remove_red_eye_rounded,
              size: 20,
              // color: context.theme.primaryColor,
            ),
            const SizedBox(width: 15.0),
            PopupMenuButton(
              position: PopupMenuPosition.under,
              // color: context.theme.bgColor,
              icon: const Icon(
                Icons.more_vert,
                size: 22,
                // color: context.theme.primaryColor,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(0.0),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const PostTest()));
                    },
                    child: const Text('Posts'),
                  ),
                ),
                PopupMenuItem(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context, MaterialPageRoute(builder: (_) => Settings())
                      // );
                    },
                    child: const Text('Settings'),
                  ),
                ),
                PopupMenuItem(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (_) => SignIn()),
                      // );
                    },
                    child: const Text('Log out'),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 5.0),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: ListView(children: [
            Container(
              height: size.height * .375,
              width: double.infinity,
              color: Colors.black12,
              child: Stack(
                children: [
                  Image(
                    width: double.infinity,
                    height: size.height * .17,
                    image: const AssetImage('assets/images/landscape3.jpg'),
                    fit: BoxFit.cover,
                    // color: Colors.orange,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: size.width * .35,
                          height: double.infinity,
                          // color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // const CircleAvatar(
                              //   child: ClipOval(
                              //     child: Image(
                              //       image: AssetImage('assets/images/me.jpg'),
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              //   radius: 50,
                              //   // ),
                              // ),
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //     context, MaterialPageRoute(builder: (context) => MyImageView(),),
                                  // );
                                },
                                child: Container(
                                  width: size.width * .250,
                                  height: size.width * .250,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      width: 1.2,
                                      // color: context.theme.primaryColor!,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        size.width * .125),
                                    image: const DecorationImage(
                                      image: AssetImage('assets/images/me.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              // const SizedBox(height: 5.0),
                              Text(
                                // userP.userName.toString() ?? '',
                                // profileModel.userName ?? 'Paramount',
                                // 'Paramount',
                                _userData?.firstName ?? 'Update profile',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  // color: context.theme.textColor,
                                ),
                              ),
                              Text(
                                // profileModel.lasnme
                                // '@paramount',
                                '@${_userData?.tagname}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  // color: context.theme.textColor,
                                ),
                              ),
                              const SizedBox(height: 15.0),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * .6,
                          height: double.infinity,
                          // color: Colors.orange,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height: size.height * .175),
                              Expanded(
                                // width: double.infinity,
                                // height: size.height * .1,
                                // color: Colors.blueAccent,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, bottom: 5.0),
                                  child: InkWell(
                                    onTap: () => _showOptionsDialog(context),
                                    child: Text(
                                      _userData?.bio ??
                                          'This is what you need to know about me... A Mobile Developer with an enthusiasm for knowledge and inventions.',
                                      style: const TextStyle(
                                        // color: context.theme.textColor,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 65.0,
                                // color: Colors.orange,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Column(
                                      children: [
                                        Text(
                                          '0',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            // color: context.theme.textColor,
                                          ),
                                        ),
                                        Text(
                                          'Posts',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            // color: context.theme.textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          _userData!.followers!.length
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            // color: context.theme.textColor,
                                          ),
                                        ),
                                        const Text(
                                          'Followers',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            // color: context.theme.textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          _userData!.following!.length
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          'Following',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            // Edit Profile
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(userData: _userData),
                  ),
                ).then((_) async {
                  setState(() {
                    _userData = newData;
                  });
                });
              },
              child: Container(
                color: Colors.black12,
                height: 35,
                width: double.infinity,
                //MediaQuery.of(context).size.width * .87,
                child: const Center(
                  child: Text('Edit profile'),
                ),
              ),
            ),
            // TABS
            Column(
              children: [
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  // color: context.theme.primaryColor,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 450),
                                margin: const EdgeInsets.only(left: 16),
                                padding: const EdgeInsets.all(12),
                                height: 40,
                                width: 75,
                                decoration: BoxDecoration(
                                  // color: Colors.black12,
                                  border: Border(
                                      bottom: current == index
                                          ? const BorderSide(
                                              // color: context.theme.primaryColor!,
                                              width: 2.5)
                                          : BorderSide.none),
                                ),
                                child: Center(
                                  child: Text(
                                    items[index],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      // color: current == index
                                      //     ? context.theme.primaryColor
                                      //     : context.theme.greyColor,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 7.5),
                  height: size.height * .40,
                  width: double.infinity,
                  child: tabss[current],
                ),
              ],
            ),
          ]),
        )
        // const Visibility(
        //   visible: true,
        //   replacement: Center(child: CircularProgressIndicator(),),
        //   child: Text(''),
        // ),
        );
  }
}
