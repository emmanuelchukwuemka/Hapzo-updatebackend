import 'dart:ui';
import 'package:haptext_api/exports.dart';

class LiveStreamApp extends StatelessWidget {
  const LiveStreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return const LiveStreamPage();
        });
  }
}

class LiveStreamPage extends StatefulWidget {
  const LiveStreamPage({super.key});

  @override
  State<LiveStreamPage> createState() => _LiveStreamPageState();
}

class _LiveStreamPageState extends State<LiveStreamPage>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  void _toggleMenu() {
    setState(() {
      _expanded = !_expanded;
      _expanded ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const AppshadowContainer(
            color: Colors.black,
            child: Icon(Icons.videocam, color: Colors.white24, size: 120)),

        // Gradient overlay
        Align(
            alignment: Alignment.bottomCenter,
            child: AppshadowContainer(
                height: 250,
                gradient: LinearGradient(colors: [
                  Colors.black.withValues(alpha: 0.8),
                  Colors.transparent
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter))),

        // Top bar
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        NetworkImage("https://i.pravatar.cc/150?img=32")),
                const SizedBox(width: 8),
                const AppText(
                    text: "StreamerName",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                const SizedBox(width: 8),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const AppText(
                        text: "LIVE",
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                const Row(
                  children: [
                    Icon(Icons.remove_red_eye, size: 18, color: Colors.white),
                    SizedBox(width: 4),
                    AppText(
                        text: "12.5k",
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Bottom area
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Comments
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _comment("alex", "This stream is fire 🔥"),
                      _comment("jane", "Hii everyone 👋"),
                      _comment("mark", "Drop the link pls"),
                      const SizedBox(height: 8),
                      _commentInput(),
                    ],
                  ),
                ),

                // Expandable action menu
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizeTransition(
                      sizeFactor: CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeOut,
                      ),
                      axisAlignment: -1.0,
                      child: Column(
                        children: [
                          _actionIcon(Icons.favorite, "12k"),
                          _actionIcon(Icons.share, "2.1k"),
                          _actionIcon(Icons.card_giftcard, "150"),
                          _actionIcon(Icons.person, "Profile"),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _toggleMenu,
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        child: AnimatedIcon(
                          icon: AnimatedIcons.menu_close,
                          progress: _controller,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _comment(String user, String text) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(children: [
          AppText(
              text: "$user: ",
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13),
          AppText(text: text, color: Colors.white, fontSize: 13),
        ]));
  }

  Widget _commentInput() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          color: Colors.white.withValues(alpha: 0.1),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.mic, color: Colors.white70, size: 20),
                  onPressed: () {
                    // Record voice note
                  }),
              const Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: "Say something...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.send, size: 18, color: Colors.white70),
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionIcon(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(children: [
        CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            child: Icon(icon, color: Colors.white, size: 22)),
        const SizedBox(height: 2),
        AppText(text: label, fontSize: 12, color: Colors.white70),
      ]),
    );
  }
}
