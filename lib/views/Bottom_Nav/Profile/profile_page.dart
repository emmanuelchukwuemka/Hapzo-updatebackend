import 'dart:developer';

import 'package:haptext_api/bloc/auth/cubit/auth_cubit.dart';
import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/bloc/people/cubit/people_cubit.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/network/export_network.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile-screen';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  int current = 0;
  late TabController tabController;

  Future<dynamic> _showOptionsDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () {},
            child: const Center(
              child: AppText(
                  text:
                      'This is what you need to know about me... A Mobile Developer with an enthusiasm for knowledge and inventions',
                  fontSize: 15,
                  textAlign: TextAlign.center),
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<PeopleCubit>().fetchUserProfileById(
          userId: context.read<AuthCubit>().useInfo.id ?? '',
          loggedInUser: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final watchPeople = context.watch<PeopleCubit>();
    final user = context.watch<AuthCubit>().useInfo;
    return BlocListener<PeopleCubit, PeopleState>(
      listener: (context, state) {
        if (state is CurrentUser) {
          setState(() {
            user.profile = state.user;
          });
        }
      },
      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const AppText(
                  text: '  Profile',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              elevation: 0,
              actions: [
                const Icon(Icons.remove_red_eye_rounded, size: 20),
                const SizedBox(width: 15.0),
                PopupMenuButton(
                    position: PopupMenuPosition.under,
                    icon: const Icon(Icons.more_vert, size: 22),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(0.0),
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30))),
                    itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const PostTest()));
                                  },
                                  child: const AppText(
                                      text: 'Posts',
                                      fontSize: 16,
                                      color: Colors.white))),
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {},
                                  child: const AppText(
                                      text: 'Settings',
                                      fontSize: 16,
                                      color: Colors.white))),
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {
                                    context.go(RouteName.login.path);
                                  },
                                  child: const AppText(
                                      text: 'Log out',
                                      fontSize: 16,
                                      color: Colors.white)))
                        ]),
                const SizedBox(width: 5.0)
              ]),
          body: Padding(
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<PeopleCubit>().fetchUserProfileById(
                    userId: user.id ?? '', loggedInUser: true);
              },
              child: ListView(children: [
                Container(
                  height: size.height * .375,
                  width: double.infinity,
                  color: Colors.black12,
                  child: Stack(
                    children: [
                      AppNetwokImage(
                          width: size.width,
                          height: size.height * .17,
                          imageUrl: user.profile?.profilePicture ?? "",
                          fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: size.width * .35,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {},
                                      child: AppNetwokImage(
                                          width: size.width * .250,
                                          height: size.width * .250,
                                          radius: size.width * 0.7,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "${ApiConstants.baseUrl}/${user.profile?.profilePicture ?? ""}")),
                                  AppText(
                                      text:
                                          "${user.profile?.firstName ?? ''} ${user.profile?.lastName ?? ''}",
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  AppText(
                                      text: '@${user.username}',
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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
                                              onTap: () =>
                                                  _showOptionsDialog(context),
                                              child: AppText(
                                                  text: user.profile?.bio ?? '',
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  textAlign: TextAlign.justify,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3)))),
                                  SizedBox(
                                      width: double.infinity,
                                      height: 65.0,
                                      // color: Colors.orange,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Column(children: [
                                              AppText(
                                                  text: '0',
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              AppText(
                                                  text: 'Posts',
                                                  fontSize: 12.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)
                                            ]),
                                            const Column(
                                              children: [
                                                AppText(
                                                    text: '0',
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                AppText(
                                                    text: 'Followers',
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ],
                                            ),
                                            Column(children: [
                                              AppText(
                                                  text:
                                                      "${watchPeople.followings.length}",
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              const AppText(
                                                  text: 'Following',
                                                  fontSize: 12.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)
                                            ])
                                          ])),
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
                      context.push(RouteName.editProfile.path);
                    },
                    child: Container(
                        color: Colors.black12,
                        height: 35,
                        width: double.infinity,
                        child: const Center(
                            child: AppText(
                                text: 'Edit profile', color: Colors.white)))),
                // TABS
                Column(
                  children: [
                    SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: items.length,
                            itemBuilder: (ctx, index) {
                              return GestureDetector(
                                  onTap: () {
                                    context.read<HomeCubit>().fetchUserPosts(
                                        userId: user.profile?.id ?? "");
                                    setState(() {
                                      current = index;
                                    });
                                  },
                                  child: Column(children: [
                                    5.verticalSpace,
                                    Center(
                                        child: AppText(
                                            text: items[index],
                                            fontWeight: FontWeight.w500,
                                            color: current == index
                                                ? context.theme.primaryColor
                                                : context.theme.greyColor,
                                            fontSize: 12.5)),
                                    10.verticalSpace,
                                    AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 450),
                                        color: current == index
                                            ? context.theme.primaryColor
                                            : Colors.transparent,
                                        height: 5,
                                        width: 75)
                                  ]));
                            })),
                    Container(
                      margin: const EdgeInsets.only(top: 7.5),
                      height: size.height * .40,
                      width: double.infinity,
                      child: tabss[current],
                    ),
                  ],
                ),
              ]),
            ),
          )
          // const Visibility(
          //   visible: true,
          //   replacement: Center(child: CircularProgressIndicator(),),
          //   child: AppText(text:''),
          // ),
          ),
    );
  }
}
