import 'dart:developer';

import 'package:google_fonts/google_fonts.dart';
import 'package:haptext_api/bloc/auth/cubit/auth_cubit.dart';
import 'package:haptext_api/bloc/people/cubit/people_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({Key? key}) : super(key: key);

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  @override
  void initState() {
    // context
    //     .read<PeopleCubit>()
    //     .fetchFollowers(userId: context.read<AuthCubit>().useInfo.id);
    // context
    //     .read<PeopleCubit>()
    //     .fetchFollowings(userId: context.read<AuthCubit>().useInfo.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final watchPeople = context.watch<PeopleCubit>();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(),
            title: const AppText(
                text: 'People',
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            // backgroundColor: context.theme.appBarColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            bottom: TabBar(
                onTap: (value) {
                  switch (value) {
                    case 0:
                      context.read<PeopleCubit>().fetchFollowers(
                          userId: context.read<AuthCubit>().useInfo.id ?? "");
                      break;
                    case 1:
                      context.read<PeopleCubit>().fetchFollowings(
                          userId: context.read<AuthCubit>().useInfo.id ?? "");
                      break;
                    default:
                  }
                },
                labelStyle: GoogleFonts.itim(fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                    GoogleFonts.itim(fontWeight: FontWeight.w500),
                tabs: const [
                  Tab(text: 'Followers'),
                  Tab(text: 'Following'),
                  Tab(text: 'Friends')
                ])),
        body: const TabBarView(
          children: [
            Followers(),
            Followings(),
            Friend(),
          ],
        ),
      ),
    );
  }
}
