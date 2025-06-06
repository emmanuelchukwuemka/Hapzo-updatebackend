import 'package:flutter/material.dart';
import 'package:haptext_api/views/nav/exports.dart';

class Friend extends StatefulWidget {
  const Friend({Key? key}) : super(key: key);

  @override
  State<Friend> createState() => _FriendState();
}

class _FriendState extends State<Friend> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // SEARCH CONTAINER
      Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        width: double.infinity,
        height: 45.0,
        decoration: BoxDecoration(
            // color: context.theme.appBarColor,
            // border: Border.all(
            //   color: Colors.orange,
            //   // (0xFFFD6104),
            //   width: 1.5,
            //   style: BorderStyle.solid
            // ),
            borderRadius: BorderRadius.circular(7.0)),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                // color: context.theme.greyColor,
              ),
            ),
            const SizedBox(width: 10.0),
            const Text(
              'Search',
              style: TextStyle(
                  // color: context.theme.greyColor,
                  ),
            ),
          ],
        ),
      ),
      // CONTENT
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                childAspectRatio: 0.8),
            itemCount: 17,
            itemBuilder: (context, index) =>
                FriendCardWidget(context, 'Sasuke', 'assets/images/sasuke.jpg'),
          ),
        ),
      ),
    ]);
  }
}
