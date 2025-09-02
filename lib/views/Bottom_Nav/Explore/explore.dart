import 'package:flutter/material.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

import '../../../common/search.dart';

class Explore extends StatelessWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: context.theme.bgColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: context.theme.primaryColor,
          ),
          title: Text(
            '  Explore',
            style: TextStyle(
              color: context.theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: context.theme.appBarColor,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Search()),
                );
              },
              icon: const Icon(
                Icons.search,
                size: 28,
              ),
              color: context.theme.primaryColor,
            ),
            const SizedBox(
              width: 1.0,
            ),
            PopupMenuButton(
              position: PopupMenuPosition.under,
              color: context.theme.bgColor,
              icon: Icon(
                Icons.more_vert,
                size: 22,
                color: context.theme.primaryColor,
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
                            builder: (_) => const Live(),
                          ));
                    },
                    child: const Text(
                      'Go live',
                    ),
                  ),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            indicatorColor: context.theme.primaryColor,
            labelColor: context.theme.primaryColor,
            unselectedLabelColor: context.theme.greyColor,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            tabs: const [
              Tab(
                text: 'Explore',
              ),
              Tab(
                text: 'Livestream',
              ),
              Tab(
                text: 'Discover',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            XploreTab1(),
            const XploreTab2(),
            const XploreTab3(),
          ],
        ),
      ),
    );
  }
}
