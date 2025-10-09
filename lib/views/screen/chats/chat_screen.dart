import 'package:haptext_api/exports.dart';

class ChatScreen extends StatefulWidget {
  final Usr user;

  const ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // This contains individual chat messages
  _buildMessage(Message chat, bool isMe) {
    return Container(
        margin: isMe
            ? const EdgeInsets.only(top: 8, bottom: 8, left: 80)
            : const EdgeInsets.only(top: 8, bottom: 8, right: 80),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
            color: isMe ? Colors.orange : Colors.blueGrey,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chat.text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                chat.time,
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ));
  }

  // This is the message composer
  _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      // color: context.theme.appBarColor,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.camera,
              color: Color(0xFFFD8502),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.orange,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Send a message...',
                          hintStyle: TextStyle(
                            color: Color(0xFFFD8502),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.emoji_emotions_outlined,
                      color: Color(0xFFFD8502),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.link_sharp,
                      color: Color(0xFFFD8502),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.send,
              color: Color(0xFFFD8502),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.theme.bgColor,
      appBar: AppBar(
        flexibleSpace: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const IndividualProfile()));
          },
          child: FlexibleSpaceBar(
            title: Text(
              widget.user.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                // color: context.theme.titleTextColor,
              ),
            ),
          ),
        ),
        // backgroundColor: context.theme.appBarColor,
        // iconTheme: IconThemeData(color: context.theme.primaryColor,),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.videocam_rounded,
              // color: context.theme.primaryColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VideoCall(),
                ),
              );
            },
          ),
          const SizedBox(width: 0.51),
          IconButton(
            icon: const Icon(
              Icons.phone,
              // color: context.theme.primaryColor,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Phones()));
            },
          ),
          const SizedBox(width: 0.51),
          PopupMenuButton(
            position: PopupMenuPosition.under,
            // color: context.theme.bgColor,
            icon: const Icon(
              Icons.more_vert, size: 22,
              // color: context.theme.primaryColor,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(0.0),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            itemBuilder: (BuildContext context) => const [
              PopupMenuItem(
                child: Text('Search'),
              ),
              PopupMenuItem(
                child: Text('New Group'),
              ),
              PopupMenuItem(
                child: Text('Starred'),
              ),
              // PopupMenuItem(child: Text('New Group'),),
            ],
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              // decoration: BoxDecoration(
              //   color: Color(0xFFFD8502)   .withValues(alpha:.4),
              //   borderRadius: const BorderRadius.only(
              //     topLeft: Radius.circular(35),
              //     topRight: Radius.circular(35),
              //   )
              // ),
              child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.only(top: 15),
                  itemCount: chats.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Message chat = chats[index];
                    final bool isMe = chat.sender.id == currentUser.id;
                    return _buildMessage(chat, isMe);
                  }),
            ),
          ),
          _buildMessageComposer()
        ],
      ),
    );
  }
}
