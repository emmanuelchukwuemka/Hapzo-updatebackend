import 'package:flutter/material.dart';
import 'package:haptext_api/exports.dart';

class Blocked extends StatefulWidget {
  const Blocked({Key? key}) : super(key: key);

  @override
  State<Blocked> createState() => _BlockedState();
}

class _BlockedState extends State<Blocked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.theme.bgColor,
      appBar: AppBar(
        // backgroundColor: context.theme.appBarColor,
        iconTheme: const IconThemeData(
          // color: context.theme.primaryColor,
        ),
        title: const Text(
          'Blocked',
          style: TextStyle(
            // color: context.theme.titleTextColor,
            // fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (BuildContext context, int index) {
          final chat = chats[index];
          return Container(
            // height: 100,
            margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5.0),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5.0),
            // decoration: BoxDecoration(
            // color: chat.unread ? const Color(0xFFFFEFEE) : context.theme.readMessageColor,
            // borderRadius: const BorderRadius.only(
            //   topRight: Radius.circular(20),
            //   bottomRight: Radius.circular(20),
            // ),
            // ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 27.0,
                      backgroundImage: AssetImage(chat.sender.imgUrl),
                    ),
                    SizedBox(width: 15),
                    Container(
                      width: MediaQuery.of(context).size.width * .5,
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(user: chat.sender),),);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chat.sender.name,
                              style: TextStyle(
                                fontSize: 15,
                                // color: context.theme.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              chat.time,
                              style: TextStyle(
                                fontSize: 12,
                                // color: context.theme.textColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    print('Unblocked button clicked');
                    showDialog(
                      context: context,
                      builder:  (_) => CustomDialog()
                    );
                  },
                  child: Text(
                    'Unblock',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      // color: context.theme.textColor,
                    ),
                  ),
                ),
              ]
            ),
          );
        },
      ),
    );
  }
}
class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * .18,
        padding: const EdgeInsets.only(top: 15, bottom: 5.0),
        decoration: BoxDecoration(
          // color: Color(0xFFAA303E),
          color: Color(0xFF2A303E),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .10,
              child: const Center(
                child: Text(
                  'Are you sure?',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    // fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            const Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'YES',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 15.0,
                  color: Color(0xFFFFEED9),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'NO',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}