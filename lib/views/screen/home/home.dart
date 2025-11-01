import 'package:haptext_api/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

import '../../navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: context.theme.bgColor,
      // drawer: Drawer(
      //   child: Container(
      //     color: context.theme.bgColor,
      //     child: ListView(
      //       physics: PageScrollPhysics(),
      //       children: [
      //         GestureDetector(
      //           onTap: () {
      //             Navigator.push(context, MaterialPageRoute(
      //                 builder: (context) => ProfilePage()
      //             ));
      //           },
      //           // child: OpenContainer(
      //           //   transitionDuration: Duration(milliseconds: 1000),
      //           //   openBuilder: (context, _) => ProfilePage(),
      //           //   closedBuilder: (context,
      //           //     VoidCallback openContainer) => Container(
      //           //     height: 195,
      //           child: const UserAccountsDrawerHeader(
      //             accountName: Text('Chukwuchi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      //             accountEmail: Text('@chukwuchi_mail', style: TextStyle(color: Colors.white)),
      //             currentAccountPicture: CircleAvatar(
      //               backgroundImage: AssetImage('assets/images/me.jpg'),
      //               radius: 80.0,
      //             ),
      //             decoration: BoxDecoration(
      //               gradient: LinearGradient(
      //                   colors: [Color(0xFFFD6104), Color(0xFFFD8502), Color(0xFFFFC203)],
      //                   begin: Alignment.bottomRight,
      //                   end: Alignment.topLeft,
      //                   tileMode: TileMode.clamp
      //               ),
      //             ),
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () {
      //             // Navigator.push(context, MaterialPageRoute(
      //             //     builder: (context) => ContactsPage()
      //             // ));
      //           },
      //           child: Container(
      //             padding: const EdgeInsets.all(10.0),
      //             margin: const EdgeInsets.symmetric(horizontal: 5.0),
      //             // decoration: BoxDecoration(
      //             //   color: Color(0xFFFD8502),
      //             //   borderRadius: BorderRadius.circular(5),
      //             // ),
      //             child: const Row(
      //               children: [
      //                 Icon(color: Color(0xFFFD8502), Icons.person_add_alt),
      //                 SizedBox(width: 29),
      //                 Text(
      //                   'Contacts',
      //                   style: TextStyle(color: Color(0xFFFD8502), fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () {
      //             // Navigator.push(context, MaterialPageRoute(
      //             //     builder: (context) => GroupsPage()
      //             // ));
      //           },
      //           child: Container(
      //             padding: EdgeInsets.all(15.0),
      //             child: const Row(
      //               children: [
      //                 Icon(color: Color(0xFFFD8502), Icons.people_outline),
      //                 SizedBox(width: 29),
      //                 Text(
      //                   'New Group',
      //                   style: TextStyle(color: Color(0xFFFD8502), fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () {
      //             // Navigator.push(context, MaterialPageRoute(
      //             //     builder: (context) => CallsPage()
      //             // ));
      //           },
      //           child: Container(
      //             padding: EdgeInsets.all(15.0),
      //             child: const Row(
      //               children: [
      //                 Icon(color: Color(0xFFFD8502), Icons.phone),
      //                 SizedBox(width: 29),
      //                 Text(
      //                   'Calls',
      //                   style: TextStyle(color: Color(0xFFFD8502), fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () {
      //             // Navigator.push(context, MaterialPageRoute(
      //             //     builder: (context) => CommunityPage()
      //             // ));
      //           },
      //           child: Container(
      //             padding: EdgeInsets.all(15.0),
      //             width: double.infinity,
      //             child: const Row(
      //               children: [
      //                 Icon(color: Color(0xFFFD8502), Icons.store_mall_directory),
      //                 SizedBox(width: 29),
      //                 Text(
      //                   'Community',
      //                   style: TextStyle(color: Color(0xFFFD8502), fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         Container(
      //           padding: const EdgeInsets.all(0),
      //           child: ExpansionTile(
      //             leading: const Icon(color: Color(0xFFFD8502), Icons.business_rounded),
      //             iconColor: Color(0xFFFD8502),
      //             collapsedIconColor: Color(0xFFFD8502),
      //             title: const Text(
      //               'Business',
      //               style: TextStyle(color: Color(0xFFFD8502), fontWeight: FontWeight.bold),
      //             ),
      //             children: [
      //               InkWell(
      //                 onTap: () {
      //                   // Navigator.push(context, MaterialPageRoute(
      //                   //     builder: (context) => ChannelsPage()
      //                   // ));
      //                 },
      //                 child: Padding(
      //                   padding: EdgeInsets.only(left: 68, bottom: 15),
      //                   child: Row(
      //                     children: const [
      //                       Text(
      //                         'Channels',
      //                         style: TextStyle(color: Color(0xFFFD8502), fontWeight: FontWeight.bold),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               InkWell(
      //                 onTap: () {
      //                   // Navigator.push(context, MaterialPageRoute(
      //                   //     builder: (context) => OnlyShowPage()
      //                   // ));
      //                 },
      //                 child: const Padding(
      //                   padding: EdgeInsets.only(left: 67, bottom: 10),
      //                   child: Row(
      //                     children: [
      //                       Text(
      //                         'Only show',
      //                         style: TextStyle(color: Color(0xFFFD8502), fontWeight: FontWeight.bold),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () {
      //             // Navigator.push(context, MaterialPageRoute(
      //             //     builder: (context) => StarredPage()
      //             // ));
      //           },
      //           child: Container(
      //             padding: EdgeInsets.all(15.0),
      //             child: const Row(
      //               children: [
      //                 Icon(color: Color(0xFFFD8502), Icons.star),
      //                 SizedBox(width: 29),
      //                 Text(
      //                   'Starred',
      //                   style: TextStyle(color: Color(0xFFFD8502), fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () {
      //             // Navigator.push(context, MaterialPageRoute(
      //             //     builder: (context) => NearbyPage()
      //             // ));
      //           },
      //           child: Container(
      //             padding: EdgeInsets.all(15.0),
      //             child: const Row(
      //               children: [
      //                 Icon(color: Color(0xFFFD8502), Icons.archive_rounded),
      //                 SizedBox(width: 29),
      //                 Text(
      //                   'Nearby',
      //                   style: TextStyle(color: Color(0xFFFD8502), fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () {
      //             // Navigator.push(context, MaterialPageRoute(
      //             //     builder: (context) => Settings()
      //             // ));
      //           },
      //           child: Container(
      //             padding: EdgeInsets.all(15.0),
      //             width: double.infinity,
      //             child: const Row(
      //               children: [
      //                 Icon(color: Color(0xFFFD8502), Icons.settings),
      //                 SizedBox(width: 29),
      //                 Text(
      //                   'Settings',
      //                   style: TextStyle(color: Color(0xFFFD8502), fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () {
      //             print('Sign Out');
      //             authController.signUserOut();
      //           },
      //           child: Container(
      //             padding: EdgeInsets.all(15.0),
      //             width: double.infinity,
      //             child: const Row(
      //               children: [
      //                 Icon(
      //                   Icons.exit_to_app_outlined,
      //                   size: 22,
      //                   color: Colors.orange,
      //                 ),
      //                 SizedBox(width: 29),
      //                 Text(
      //                   'Sign Out',
      //                   style: TextStyle(color: Color(0xFFFD8502), fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     )
      //   )
      // ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(' Chats',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          // backgroundColor: context.theme.appBarColor,
          elevation: 10.0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Navigation()));
              },
              icon: const Icon(Icons.cloud_outlined),
              iconSize: 22,
              // color: context.theme.primaryColor,
            ),
            // SizedBox(width: 0.5),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              iconSize: 22,
              // color: context.theme.primaryColor,
            ),
            // SizedBox(width: 5),
            PopupMenuButton(
              position: PopupMenuPosition.under,
              color: context.theme.bgColor,
              icon: const Icon(
                Icons.more_vert, size: 22,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Phones(),
                          ));
                    },
                    child: const Text('Calls'),
                  ),
                ),
                const PopupMenuItem(
                  child: Text('Contacts'),
                ),
                const PopupMenuItem(
                  child: Text('New Group'),
                ),
                const PopupMenuItem(
                  child: Text('Channel'),
                ),
                const PopupMenuItem(
                  child: Text('Starred'),
                ),
                PopupMenuItem(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => Settings(),));
                    },
                    child: const Text('Settings'),
                  ),
                ),
              ],
            ),
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
                    tileMode: TileMode.clamp),
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: const Column(children: [
          FavouriteContacts(),
          // RecentChats(),
        ]),
      ),
    );
  }
}
