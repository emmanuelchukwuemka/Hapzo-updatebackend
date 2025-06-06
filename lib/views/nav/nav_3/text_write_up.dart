import 'package:flutter/material.dart';

class WriteText extends StatefulWidget {
  const WriteText({Key? key}) : super(key: key);
  @override
  State<WriteText> createState() => _WriteTextState();
}

class _WriteTextState extends State<WriteText> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 35),
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              // color: context.theme.primaryColor,
              color: Colors.blue[800],
              child: const Center(
                child: Text(
                  'Write a message',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.save, color: Colors.white, size: 22),
                      SizedBox(height: 9.0),
                      Text(
                        'Scheduled',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                  Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.emoji_emotions_outlined,
                        color: Colors.white, size: 22),
                    SizedBox(height: 10),
                    Text(
                      'Emoji',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    SizedBox(height: 20),
                    Icon(Icons.access_alarms_rounded,
                        color: Colors.white, size: 22),
                    SizedBox(height: 10),
                    Text(
                      'Schedule\nTime',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    SizedBox(height: 20),
                    Icon(Icons.person_add, color: Colors.white, size: 22),
                    SizedBox(height: 10),
                    Text(
                      'Tag\npeople',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    SizedBox(height: 20),
                    Icon(Icons.star_half_rounded,
                        color: Colors.white, size: 22),
                    SizedBox(height: 10),
                    Text(
                      'Background',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    SizedBox(height: 20),
                    // Icon(Icons.add_business_rounded, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
