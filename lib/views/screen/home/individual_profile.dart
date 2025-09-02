import 'package:flutter/material.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class IndividualProfile extends StatefulWidget {
  const IndividualProfile({Key? key}) : super(key: key);

  @override
  State<IndividualProfile> createState() => _IndividualProfileState();
}

class _IndividualProfileState extends State<IndividualProfile> {
  _SelectRestriction() {
    _selectedVal = ites[0];
  }

  final ites = [
    "Texts only",
    "Calls only",
    "Video calls only",
    "Voice notes only",
    "Default",
  ];
  List<String> items = [
    "MEDIA",
    "DOCS",
    "LINKS",
    "AUDIO",
    "PLANS",
  ];
  String? _selectedVal = "";

  // List<IconData> icons = [
  //   Icons.ac_unit_outlined,
  //   Icons.add_box_outlined,
  //   Icons.access_alarms_rounded,
  //   Icons.construction,
  //   Icons.camera,
  //   Icons.label_important_outline
  // ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.bgColor,
        appBar: AppBar(
          backgroundColor: context.theme.appBarColor,
          iconTheme: IconThemeData(color: context.theme.primaryColor),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.phone,
                color: context.theme.primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert, color: context.theme.primaryColor),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.link_sharp, color: Color(0xFFFD8502),),
            // ),
          ],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: context.theme.bgColor,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: context.theme.primaryColor,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.theme.titleTextColor,
                            fontSize: 18),
                      ),
                      Text(
                        'Last seen yesterday at 3:30 AM',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: context.theme.titleTextColor,
                          fontSize: 12,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 18),
              child: Text(
                'Info',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.theme.titleTextColor,
                  fontSize: 18,
                ),
              ),
            ),
            // SizedBox(height: 10),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 17.5, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@romanFortune',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: context.theme.chatTitleColor,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Username',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: context.theme.greyColor,
                          fontSize: 14),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 1.5,
              width: double.infinity,
              // color: Colors.white,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 17.5, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '+234 7053526670',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: context.theme.chatTitleColor,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Mobile',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: context.theme.greyColor,
                        fontSize: 14,
                      ),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 1.5,
              width: double.infinity,
              // color: Colors.white,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 17.5, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Off',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: context.theme.chatTitleColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Notification',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: context.theme.greyColor,
                            fontSize: 14,
                          ),
                        ),
                      ]),
                  Icon(Icons.notifications_active_rounded,
                      color: context.theme.primaryColor, size: 20)
                ],
              ),
            ),
            const SizedBox(
              height: 1.5,
              width: double.infinity,
              // color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: DropdownButtonFormField(
                initialValue: ites[4],
                items: ites
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(color: context.theme.greyColor),
                          ),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedVal = val as String;
                  });
                },
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: context.theme.primaryColor,
                ),
                decoration: InputDecoration(
                  labelText: 'Restriction',
                  labelStyle: TextStyle(
                      color: context.theme.chatTitleColor,
                      fontWeight: FontWeight.bold),
                  // focusColor: Colors.transparent,
                  // border: UnderlineInputBorder(),
                ),
              ),
            ),
            // ExpansionTile(
            //   iconColor: Color(0xFFFD8502),
            //   collapsedIconColor: Color(0xFFFD8502),
            //   title: Text(
            //     'Only view',
            //     style: TextStyle(
            //         fontWeight: FontWeight.w600,
            //         color: Colors.blueGrey[800],
            //         fontSize: 12),
            //   ),
            //   subtitle: const Text(
            //     'Restrictions',
            //     style: TextStyle(
            //         fontWeight: FontWeight.w500,
            //         color: Colors.blueGrey,
            //         fontSize: 12),
            //   ),
            //   expandedCrossAxisAlignment: CrossAxisAlignment.start,
            //   children: [],
            // ),
            const SizedBox(
              height: 1.85,
              width: double.infinity,
              // color: Colors.white,
            ),
            Container(
              height: 40,
              width: double.infinity,
              color: context.theme.primaryColor,
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
                            duration: const Duration(milliseconds: 280),
                            margin: const EdgeInsets.only(left: 16),
                            padding: const EdgeInsets.all(12),
                            height: 40,
                            width: 75,
                            decoration: BoxDecoration(
                              // color: Colors.black12,
                              border: Border(
                                  bottom: current == index
                                      ? BorderSide(
                                          color: context.theme.bgColor!,
                                          width: 3.5)
                                      : BorderSide.none),
                            ),
                            child: Center(
                              child: Text(
                                items[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: current == index
                                      ? context.theme.appBarColor
                                      : Colors.blueGrey[800],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ]),
        ));
  }
}
