import 'package:flutter/material.dart';
import 'package:haptext_api/exports.dart';

class FavouriteContacts extends StatelessWidget {
  const FavouriteContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Container(
          //   color: Colors.orange   .withValues(alpha:.20),
          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Text(
          //         'Favourite Contacts',
          //         style: TextStyle(fontSize: 15.0, color: Colors.blueGrey, fontWeight: FontWeight.w500, letterSpacing: 0.51),
          //       ),
          //       IconButton(
          //         onPressed: () {},
          //         icon: Icon(Icons.keyboard_arrow_up, color: Colors.blueGrey),
          //       )
          //     ],
          //   ),
          // ),
          Container(
            color: Colors.blueGrey[800],
            child: ExpansionTile(
                collapsedIconColor: const Color(0xFFFFEED9),
                iconColor: const Color(0xFFFFEED9),
                title: const Text(
                  'Pinned  Contacts',
                  style: TextStyle(
                      color: Color(0xFFFFEED9), fontWeight: FontWeight.w500),
                ),
                children: [
                  Container(
                    color: const Color(0xFFFFEED9),
                    height: 100,
                    child: ListView.builder(
                        padding: const EdgeInsets.only(left: 5.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: favorites.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          ChatScreen(user: favorites[index])));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 28.0,
                                    backgroundImage:
                                        AssetImage(favorites[index].imgUrl),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    favorites[index].name,
                                    style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox.shrink(),
                ]),
          )
        ],
      ),
    );
  }
}
