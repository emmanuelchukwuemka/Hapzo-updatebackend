import 'package:haptext_api/exports.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class FriendProfilePage extends StatefulWidget {
  const FriendProfilePage({Key? key}) : super(key: key);

  @override
  State<FriendProfilePage> createState() => _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: context.theme.primaryColor,
        ),
        backgroundColor: context.theme.appBarColor,
        title: Text(
          '@Roman Fortune',
          style: TextStyle(
              color: context.theme.titleTextColor, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          const PictureContainer(),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Roman Fortune',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.theme.titleTextColor,
                // blueGrey[800],
              ),
            ),
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '82k',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Text(
                'following',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '3.8k',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(width: 4),
              Text(
                'followers',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(width: 4),
              Text(
                '12k',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(width: 4),
              Text(
                'Mutual',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: context.theme.greyColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Row(
                      children: [
                        SizedBox(width: 3),
                        Icon(
                          Icons.library_add,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Follow',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
                const SizedBox(width: 10),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                        color: context.theme.primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Row(
                      children: [
                        SizedBox(width: 3),
                        Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Message',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  // color: Colors.grey[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Name',
                          style: TextStyle(
                              color: context.theme.greyColor,
                              fontWeight: FontWeight.w500)),
                      const Text('Roman Fortune Combo',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tag Name',
                          style: TextStyle(
                              color: context.theme.greyColor,
                              fontWeight: FontWeight.w500)),
                      const Text('@hapzz',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Birthday',
                        style: TextStyle(
                            color: context.theme.greyColor,
                            fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        '01/01/0001',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Occupation',
                          style: TextStyle(
                              color: context.theme.greyColor,
                              fontWeight: FontWeight.w500)),
                      const Text('Hapztext CEO',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Height',
                          style: TextStyle(
                              color: context.theme.greyColor,
                              fontWeight: FontWeight.w500)),
                      const Text('1.76m',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ethnicity',
                          style: TextStyle(
                              color: context.theme.greyColor,
                              fontWeight: FontWeight.w500)),
                      const Text('Christianity',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Relationship status',
                        style: TextStyle(
                            color: context.theme.greyColor,
                            fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        'Single',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Looking for',
                          style: TextStyle(
                              color: context.theme.greyColor,
                              fontWeight: FontWeight.w500)),
                      const Text('Anime, Football',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Current location',
                          style: TextStyle(
                              color: context.theme.greyColor,
                              fontWeight: FontWeight.w500)),
                      const Text('Abuja, Nigeria',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
