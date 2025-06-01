import 'package:flutter/material.dart';
import 'package:haptext_api/views/nav/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({Key? key}) : super(key: key);

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            // color: context.theme.primaryColor,
          ),
          title: const Text(
            '  People',
            style: TextStyle(
              // color: context.theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          // backgroundColor: context.theme.appBarColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          // leading: SizedBox.shrink(),
          bottom: const TabBar(
            // indicatorColor: context.theme.primaryColor,
            // labelColor: context.theme.primaryColor,
            // unselectedLabelColor: context.theme.greyColor,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
            tabs: [
              Tab(text: 'Followers',),
              Tab(text: 'Following',),
              Tab(text: 'Friends',),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Foller(),
            Follin(),
            Friend(),
          ],
        ),
      ),
    );
  }
}
