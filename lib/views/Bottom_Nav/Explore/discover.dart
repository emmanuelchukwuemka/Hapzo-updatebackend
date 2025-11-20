import 'dart:math';
import 'package:haptext_api/exports.dart';

// class XploreTab3 extends StatelessWidget {
//   const XploreTab3({Key? key}) : super(key: key);

//   // final TextEditingController _searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     // final size = MediaQuery.of(context).size;

//     // Future showToast(String message) async {
//     //   await Fluttertoast.cancel();
//     //
//     //   Fluttertoast.showToast(msg: message, fontSize: 18,);
//     // }

//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 1,
//             child: Container(
//               color: Colors.black54,
//               child: Stack(children: [
//                 const Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CircleAvatar(
//                         radius: 50,
//                         backgroundImage: AssetImage(
//                           'assets/images/asta.jpg',
//                         ),
//                       ),
//                       Text(
//                         'Connecting . . .',
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Container(
//                       margin: const EdgeInsets.only(top: 25.0, right: 25.0),
//                       child: const Icon(
//                         // FontAwesomeIcons.expand,
//                         Icons.add, color: Colors.white, size: 22.0,
//                       )),
//                 ),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Container(
//                       margin: const EdgeInsets.only(top: 25.0, left: 25.0),
//                       child: const Icon(
//                         Icons.flag,
//                         color: Colors.green,
//                         size: 30,
//                       )),
//                 ),
//               ]),
//             ),
//           ),
//           const SizedBox(height: 1.0),
//           Expanded(
//             flex: 1,
//             child: Container(
//               color: Colors.black54,
//               child: const Stack(children: [
//                 Center(
//                   child: CircleAvatar(
//                     radius: 55.0,
//                     backgroundImage: AssetImage(
//                       'assets/images/yuno.jpg',
//                     ),
//                   ),
//                 ),
//                 // Align(
//                 //   alignment: Alignment.bottomRight,
//                 //   child: Container(
//                 //     margin: EdgeInsets.only(bottom: 25.0, right: 25.0),
//                 //     height: 50,
//                 //     width: 50,
//                 //     decoration: BoxDecoration(
//                 //       color: Colors.white,
//                 //       borderRadius: BorderRadius.circular(25),
//                 //       boxShadow: [BoxShadow(
//                 //         blurRadius: 2.0,
//                 //         offset: Offset(1.0, 1.0),
//                 //         color: Colors.black87,
//                 //       )],
//                 //     ),
//                 //     child: Center(
//                 //       child: IconButton(
//                 //         onPressed: () {
//                 //           print('Video call menu button clicked');
//                 //         },
//                 //         icon: Icon(Icons.add, color: Colors.orange,
//                 //           size: 30,),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//               ]),
//             ),
//           ),
//           // Container(
//           //   width: size.width,
//           //   height: size.height * .55,
//           //   margin: const EdgeInsets.all(3.0),
//           //   decoration: BoxDecoration(
//           //     color: Colors.white,
//           //     borderRadius: BorderRadius.circular(15),
//           //   ),
//           //   child: Stack(
//           //     children: [
//           //       Center(
//           //         child: Image(
//           //           height: double.infinity,
//           //           width: double.infinity,
//           //           image: AssetImage('assets/images/sasuke.jpg'),
//           //           fit: BoxFit.cover,
//           //         ),
//           //       ),
//           //       Padding(
//           //         padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
//           //         child: Column(
//           //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //           children: [
//           //             Row(
//           //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //               crossAxisAlignment: CrossAxisAlignment.start,
//           //               children: [
//           //                 Column(
//           //                   crossAxisAlignment: CrossAxisAlignment.start,
//           //                   children: [
//           //                     Text('Fortune', style: TextStyle(color: Colors.orange,
//           //                       fontSize: 15,
//           //                       fontWeight: FontWeight.bold,),),
//           //                     Text('52 mins ago',
//           //                       style: TextStyle(color: Colors.orange, fontSize: 12,),),
//           //                   ],
//           //                 ),
//           //                 InkWell(
//           //                   onTap: () {
//           //                     print('Follow button clicked');
//           //                   },
//           //                   child: Text(
//           //                     'Follow...',
//           //                     style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold,),
//           //                   ),
//           //                 )
//           //               ],
//           //             ),
//           //             Expanded(
//           //               child: Row(
//           //                 mainAxisSize: MainAxisSize.max,
//           //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //                 crossAxisAlignment: CrossAxisAlignment.end,
//           //                 children: [
//           //                   Container(
//           //                     width: size.width * .65,
//           //                     height: size.height * .15,
//           //                     padding: const EdgeInsets.only(left: 10),
//           //                     child: Row(
//           //                       mainAxisAlignment: MainAxisAlignment.start,
//           //                       // crossAxisAlignment: CrossAxisAlignment.center,
//           //                       children: [
//           //                         CircleAvatar(
//           //                           radius: 30,
//           //                           backgroundImage: AssetImage('assets/images/me.jpg'),
//           //                         ),
//           //                         SizedBox(width: 5),
//           //                         Column(
//           //                           mainAxisAlignment: MainAxisAlignment.center,
//           //                           children: [
//           //                             Text(
//           //                               'Caption',
//           //                               style: const TextStyle(
//           //                                 fontSize: 13,
//           //                                 color: Colors.orange,
//           //                               ),
//           //                             ),
//           //                             Row(
//           //                               children: [
//           //                                 const Icon(
//           //                                   Icons.music_note,
//           //                                   size: 15,
//           //                                   color: Colors.orange,
//           //                                 ),
//           //                                 Text(
//           //                                   'Title',
//           //                                   style: const TextStyle(
//           //                                     fontSize: 13,
//           //                                     color: Colors.orange,
//           //                                     fontWeight: FontWeight.bold,
//           //                                   ),
//           //                                 ),
//           //                               ],
//           //                             )
//           //                           ],
//           //                         ),
//           //                       ],
//           //                     ),
//           //                   ),
//           //                   // Container(
//           //                   //   width: 100,
//           //                   //   margin: EdgeInsets.only(top: size.height/55),
//           //                   //   child: Column(
//           //                   //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           //                   //     children: [
//           //                   //       // buildProfile(data.profilePhoto),
//           //                   //       Column(
//           //                   //         children: [
//           //                   //           InkWell(
//           //                   //             onTap: () {},
//           //                   //             child: Icon(Icons.favorite, size: 30, color: Colors.orange,),
//           //                   //           ),
//           //                   //           Text(
//           //                   //             '2,200',
//           //                   //             style: TextStyle(fontSize: 15, color: Colors.orange,),
//           //                   //           ),
//           //                   //           SizedBox(height: 7),
//           //                   //           InkWell(onTap: () {}, child: Icon(Icons.comment, size: 30, color: Colors.orange,),),
//           //                   //           Text(
//           //                   //             '29',
//           //                   //             style: TextStyle(fontSize: 15, color: Colors.orange,),
//           //                   //           ),
//           //                   //           SizedBox(height: 7),
//           //                   //           InkWell(onTap: () {}, child: Icon(Icons.reply, size: 30, color: Colors.orange,),),
//           //                   //           Text(
//           //                   //             // data.shareCount.toString(),
//           //                   //             '2',
//           //                   //             style: TextStyle(fontSize: 15, color: Colors.orange,),),
//           //                   //           SizedBox(height: 7),
//           //                   //         ],
//           //                   //       ),
//           //                   //     ],
//           //                   //   ),
//           //                   // ),
//           //                   Container(
//           //                     width: 80,
//           //                     // margin: EdgeInsets.only(top: size.height/8),
//           //                     // color: Colors.black12,
//           //                     child: Column(
//           //                       mainAxisAlignment: MainAxisAlignment.center,
//           //                       children: [
//           //                         // buildProfile(data.profilePhoto),
//           //                         SizedBox(height: 25),
//           //                         InkWell(
//           //                           onTap: () {},
//           //                           child: Icon(Icons.favorite, size: 20, color: Colors.orange,),
//           //                         ),
//           //                         Text(
//           //                           '271',
//           //                           style: TextStyle(fontSize: 12, color: Colors.orange,),
//           //                         ),
//           //                         SizedBox(height: 25),
//           //                         InkWell(onTap: () {}, child: Icon(Icons.mode_comment_rounded, size: 20, color: Colors.orange,),),
//           //                         Text(
//           //                           '29',
//           //                           style: TextStyle(fontSize: 12, color: Colors.orange,),
//           //                         ),
//           //                         SizedBox(height: 25),
//           //                         InkWell(onTap: () {}, child: Icon(Icons.reply, size: 20, color: Colors.orange,),),
//           //                         Text(
//           //                           '2',
//           //                           style: TextStyle(fontSize: 12, color: Colors.orange,),
//           //                         ),
//           //                         SizedBox(height: 25),
//           //                         InkWell(onTap: () {}, child: Icon(Icons.download, size: 20, color: Colors.orange,),),
//           //                         Text(
//           //                           '2',
//           //                           style: TextStyle(fontSize: 12, color: Colors.orange,),
//           //                         ),
//           //                         SizedBox(height: 15),
//           //                       ],
//           //                     ),
//           //                   ),
//           //                 ],
//           //               ),
//           //             ),
//           //           ],
//           //         ),
//           //       )
//           //     ],
//           //   ),
//           // ),
//         ],
//       ),
//       // floatingActionButton: SpeedDial(
//       //   animatedIcon: AnimatedIcons.menu_close,
//       //   animationDuration: Duration(milliseconds: 400),
//       //   backgroundColor: context.theme.primaryColor,
//       //   elevation: 6.0,
//       //   overlayColor: Colors.black,
//       //   overlayOpacity: 0.4,
//       //   children: [
//       //     SpeedDialChild(
//       //       child: Icon(FontAwesomeIcons.thumbsUp),
//       //       label: 'Start',
//       //       // onTap: () => showToast('Selected github'),
//       //     ),
//       //     SpeedDialChild(
//       //       child: Icon(Icons.mail),
//       //       label: 'Message',
//       //       // onTap: () => showToast('Selected mail'),
//       //     ),
//       //     SpeedDialChild(
//       //       child: Icon(FontAwesomeIcons.shuffle),
//       //       label: 'Shuffle',
//       //     ),
//       //     SpeedDialChild(
//       //       child: Icon(Icons.videocam_off_outlined),
//       //       label: 'Video',
//       //       // onTap: () => showToast('Selected share'),
//       //     ),
//       //     SpeedDialChild(
//       //       child: Icon(Icons.mic_off),
//       //       label: 'Mic',
//       //       // onTap: () => showToast('Selected twitter'),
//       //     ),
//       //     // SpeedDialChild(
//       //     //   child: Icon(Icons.copy),
//       //     //   label: 'Copy',
//       //     //   // onTap: () => showToast('Selected copy'),
//       //     // ),
//       //     // SpeedDialChild(
//       //     //   child: Icon(FontAwesomeIcons.linkedin),
//       //       // label: 'Share',
//       //       // onTap: () => showToast('Selected linkedin'),
//       //     // ),
//       //   ]
//       // ),
//     );
//   }
// }

class RemoteUser {
  final String id;
  final String name;
  final String countryFlag; // emoji
  final Color accent;
  RemoteUser({
    required this.id,
    required this.name,
    required this.countryFlag,
    required this.accent,
  });
}

class XploreTab3 extends StatefulWidget {
  const XploreTab3({super.key});
  @override
  State<XploreTab3> createState() => _XploreTab3State();
}

class _XploreTab3State extends State<XploreTab3>
    with SingleTickerProviderStateMixin {
  // --- mock pool ---
  final List<RemoteUser> _pool = [
    RemoteUser(
        id: 'u1', name: 'Ana', countryFlag: '🇪🇸', accent: Colors.deepPurple),
    RemoteUser(
        id: 'u2', name: 'Liam', countryFlag: '🇮🇪', accent: Colors.teal),
    RemoteUser(
        id: 'u3', name: 'Sora', countryFlag: '🇯🇵', accent: Colors.indigo),
    RemoteUser(
        id: 'u4', name: 'Maya', countryFlag: '🇮🇳', accent: Colors.amber),
    RemoteUser(
        id: 'u5', name: 'Roman', countryFlag: '🇷🇺', accent: Colors.cyan),
    RemoteUser(
        id: 'u6', name: 'Eve', countryFlag: '🇫🇷', accent: Colors.pinkAccent),
  ];

  late RemoteUser _current;
  final String _localName = 'You';

  // UI states
  bool _showActions = false;
  bool _showChat = false;
  bool _fullScreenRemote = false; // if true remote occupies more space
  bool _muted = false; // local mic mute
  bool _videoMuted = false; // local video off
  bool _connecting = false;

  // chat state (disappears on shuffle)
  final List<Map<String, String>> _messages = [];
  final TextEditingController _msgController = TextEditingController();

  // random
  final Random _rnd = Random();

  // animation controller for subtle pulses when connecting (optional)
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _current = _pool.first;
    _pulseController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400))
      ..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _msgController.dispose();
    super.dispose();
  }

  // ---------------- Actions ----------------

  void _toggleActions() => setState(() => _showActions = !_showActions);
  void _toggleChat() => setState(() => _showChat = !_showChat);
  void _toggleMute() => setState(() => _muted = !_muted);
  void _toggleVideoMute() => setState(() => _videoMuted = !_videoMuted);

  Future<void> _shuffle() async {
    setState(() {
      _connecting = true;
      _showChat = false;
    });

    // simulate network latency
    await Future.delayed(const Duration(milliseconds: 700));

    // pick a different user
    if (_pool.length > 1) {
      RemoteUser next = _current;
      while (next.id == _current.id) {
        next = _pool[_rnd.nextInt(_pool.length)];
      }
      setState(() {
        _current = next;
        _messages.clear(); // chat disappears on shuffle
        _connecting = false;
        _fullScreenRemote = false;
        // keep mute/video state (your own settings persist)
      });
    } else {
      setState(() {
        _connecting = false;
      });
    }
  }

  void _toggleFullScreenRemote() {
    setState(() => _fullScreenRemote = !_fullScreenRemote);
  }

  void _tapLocalPreview() {
    // user taps their own preview -> toggle local video mute for convenience
    _toggleVideoMute();
  }

  void _sendMessage(String text) {
    final t = text.trim();
    if (t.isEmpty) return;
    setState(() {
      _messages.add({'from': 'me', 'text': t});
      // quick simulated reply (friendly)
      _messages.add({'from': 'them', 'text': '${_current.name}: cool!'});
      _msgController.clear();
    });
  }

  // gift sheet
  // void _showGiftModal() {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.grey[900],
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
  //     builder: (ctx) {
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  //         child: Column(mainAxisSize: MainAxisSize.min, children: [
  //           Row(children: [
  //             const Text('Send a Gift',
  //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
  //             const Spacer(),
  //             Text(_current.name, style: const TextStyle(color: Colors.white54))
  //           ]),
  //           const SizedBox(height: 12),
  //           Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
  //             _giftOption('🌹', 'Rose', 0),
  //             _giftOption('🍫', 'Treat', 20),
  //             _giftOption('🎁', 'Box', 50),
  //             _giftOption('🚀', 'Boost', 120),
  //           ]),
  //           const SizedBox(height: 12),
  //           const Divider(color: Colors.white12),
  //           const SizedBox(height: 8),
  //           Row(children: [
  //             const Text('Send coins:',
  //                 style: TextStyle(color: Colors.white70)),
  //             const SizedBox(width: 12),
  //             ElevatedButton(
  //                 onPressed: () => _sendCoins(10), child: const Text('10')),
  //             const SizedBox(width: 8),
  //             ElevatedButton(
  //                 onPressed: () => _sendCoins(50), child: const Text('50')),
  //             const SizedBox(width: 8),
  //             ElevatedButton(
  //                 onPressed: () => _sendCoins(100), child: const Text('100')),
  //             const Spacer(),
  //             TextButton(
  //                 onPressed: () => Navigator.pop(ctx),
  //                 child: const Text('Cancel')),
  //           ]),
  //           const SizedBox(height: 12),
  //         ]),
  //       );
  //     },
  //   );
  // }

  Widget _giftOption(String emoji, String label, int cost) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Sent $label to ${_current.name} ${cost > 0 ? '($cost coins)' : ''}')));
      },
      child: Column(children: [
        Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white12, borderRadius: BorderRadius.circular(12)),
            child: Text(emoji, style: const TextStyle(fontSize: 24))),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white70)),
        if (cost > 0)
          Text('$cost',
              style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ]),
    );
  }

  void _sendCoins(int amount) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sent $amount coins to ${_current.name}')));
  }

  // show friend request (mock)
  void _showFriendAdded() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Friend request sent to ${_current.name} (mock)')));
  }

  void _reportUser() {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reported ${_current.name} (mock)')));
  }

  // ---------------- UI building helpers ----------------

  Widget _remotePreview({required bool large}) {
    // purely visual placeholder (no camera)
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // tapping remote toggles full screen remote to focus on them
        setState(() {
          _fullScreenRemote = true;
        });
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _current.accent,
        ),
        child: Stack(children: [
          // subtle pattern to feel like video (no heavy resources)
          Positioned.fill(
              child: Opacity(
                  opacity: 0.06, child: Container(color: Colors.black))),
          Positioned.fill(
            child: Center(
              child: Text(
                _current.name[0],
                style: TextStyle(
                    fontSize: large ? 120 : 40,
                    fontWeight: FontWeight.w800,
                    color: Colors.white.withOpacity(0.96)),
              ),
            ),
          ),
          Positioned(
              left: 12,
              top: 12,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    Text('${_current.countryFlag}  ${_current.name}',
                        style: const TextStyle(color: Colors.white))
                  ]))),
          if (_connecting)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(height: 6),
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Connecting...', style: TextStyle(color: Colors.white70))
                ])),
              ),
            ),
          if (_videoMuted)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.45),
                child: const Center(
                    child: Icon(Icons.videocam_off,
                        color: Colors.white54, size: 48)),
              ),
            ),
        ]),
      ),
    );
  }

  Widget _localPreviewSmall() {
    return GestureDetector(
      onTap: _tapLocalPreview,
      child: Container(
        width: 120,
        height: 80,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: Colors.grey[850], borderRadius: BorderRadius.circular(12)),
        child: Stack(children: [
          Center(
              child: Text(_localName[0],
                  style: const TextStyle(fontSize: 30, color: Colors.white))),
          Positioned(
              left: 8,
              top: 8,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text('You',
                      style: TextStyle(color: Colors.white54)))),
          if (_videoMuted)
            Positioned.fill(
                child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                        child:
                            Icon(Icons.videocam_off, color: Colors.white54)))),
        ]),
      ),
    );
  }

  Widget _actionButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap,
      bool active = false}) {
    final bg = active ? Colors.cyanAccent.withOpacity(0.12) : Colors.white12;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Material(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(icon, color: Colors.white)),
        ),
      ),
      const SizedBox(height: 6),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
    ]);
  }

  // ---------------- Main build ----------------

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;

    // layout rules:
    // - If _fullScreenRemote true -> remote is larger (flex 2 : 1)
    // - Else remote:local = 1 : 0.45 roughly (desktop-like top/bottom)
    final remoteFlex = _fullScreenRemote ? 3 : 2;
    final localFlex = _fullScreenRemote ? 0 : 1;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF121212), Color(0xFF18191B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: Row(
            children: [
              // main area
              Expanded(
                flex: _fullScreenRemote ? 1 : 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    children: [
                      // top control row
                      Row(
                        children: [
                          // timer placeholder
                          Expanded(child: Container()),
                          IconButton(
                            icon: Icon(_muted ? Icons.mic_off : Icons.mic,
                                color:
                                    _muted ? Colors.redAccent : Colors.white70),
                            tooltip: _muted ? 'Unmute' : 'Mute',
                            onPressed: _toggleMute,
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: Icon(
                                _videoMuted
                                    ? Icons.videocam_off
                                    : Icons.videocam,
                                color: _videoMuted
                                    ? Colors.redAccent
                                    : Colors.white70),
                            tooltip: _videoMuted
                                ? 'Enable camera'
                                : 'Disable camera',
                            onPressed: _toggleVideoMute,
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: Icon(
                                _fullScreenRemote
                                    ? Icons.fullscreen_exit
                                    : Icons.fullscreen,
                                color: Colors.white70),
                            tooltip: _fullScreenRemote
                                ? 'Exit fullscreen'
                                : 'Fullscreen remote',
                            onPressed: _toggleFullScreenRemote,
                          ),
                          const SizedBox(width: 6),
                          IconButton(
                            icon: const Icon(Icons.shuffle,
                                color: Colors.white70),
                            tooltip: 'Shuffle (next)',
                            onPressed: _shuffle,
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // remote (top) area
                      Expanded(
                        flex: remoteFlex,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeInOut,
                          child: _remotePreview(large: _fullScreenRemote),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // local (bottom) area: show only when not fullscreen remote
                      if (!_fullScreenRemote)
                        Expanded(
                          flex: localFlex,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 280),
                            curve: Curves.easeInOut,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: _localPreviewSmall(),
                            ),
                          ),
                        ),

                      const SizedBox(height: 10),

                      // action bar (collapsible)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 260),
                        height: _showActions ? 120 : 54,
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.55),
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12))),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: _toggleActions,
                              child: Icon(
                                  _showActions
                                      ? Icons.keyboard_arrow_down_rounded
                                      : Icons.keyboard_arrow_up_rounded,
                                  color: Colors.white70),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: AnimatedCrossFade(
                                duration: const Duration(milliseconds: 240),
                                firstChild: const SizedBox.shrink(),
                                secondChild: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // _actionButton(
                                    //     icon: Icons.card_giftcard,
                                    //     label: 'Gift',
                                    //     onTap: _showGiftModal),
                                    _actionButton(
                                        icon: Icons.chat_bubble_outline,
                                        label: 'Chat',
                                        onTap: _toggleChat),
                                    _actionButton(
                                        icon: Icons.person_add_alt_1,
                                        label: 'Add Friend',
                                        onTap: _showFriendAdded),
                                    _actionButton(
                                        icon: Icons.flag,
                                        label: 'Report',
                                        onTap: _reportUser),
                                    _actionButton(
                                        icon: Icons.call_end,
                                        label: 'End',
                                        onTap: () =>
                                            Navigator.of(context).maybePop()),
                                  ],
                                ),
                                crossFadeState: _showActions
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // right side panel: chat / info (collapsible)
              AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                width: _showChat ? min(420, width * 0.36) : 0,
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.85),
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(12))),
                child: _showChat ? _buildChatPanel() : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatPanel() {
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            const SizedBox(width: 12),
            CircleAvatar(
                backgroundColor: _current.accent,
                child: Text(_current.name[0],
                    style: const TextStyle(color: Colors.white))),
            const SizedBox(width: 12),
            Expanded(
                child: Text('${_current.name} • ${_current.countryFlag}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600))),
            IconButton(
                icon: const Icon(Icons.close, color: Colors.white70),
                onPressed: _toggleChat),
          ],
        ),
        const Divider(color: Colors.white10),
        Expanded(
          child: _messages.isEmpty
              ? const Center(
                  child: Text('Say hi — messages disappear when you shuffle',
                      style: TextStyle(color: Colors.white54)))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _messages.length,
                  itemBuilder: (context, idx) {
                    final m = _messages[idx];
                    final isMe = m['from'] == 'me';
                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                            color: isMe ? Colors.blueAccent : Colors.grey[800],
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(m['text']!,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    );
                  },
                ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          color: Colors.black54,
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: _msgController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: 'Send message (disappears on next shuffle)',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none),
                onSubmitted: (t) => _sendMessage(t),
              ),
            ),
            IconButton(
                icon: const Icon(Icons.send, color: Colors.cyanAccent),
                onPressed: () => _sendMessage(_msgController.text)),
          ]),
        ),
      ],
    );
  }
}
