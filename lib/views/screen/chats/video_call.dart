import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Participant {
  final String id;
  String name;
  bool muted;
  bool videoOn;
  bool sharing; // is screen-sharing
  bool speaking; // active speaker highlight

  Participant({
    required this.id,
    required this.name,
    this.muted = false,
    this.videoOn = true,
    this.sharing = false,
    this.speaking = false,
  });

  Participant copyWith({
    String? name,
    bool? muted,
    bool? videoOn,
    bool? sharing,
    bool? speaking,
  }) {
    return Participant(
      id: id,
      name: name ?? this.name,
      muted: muted ?? this.muted,
      videoOn: videoOn ?? this.videoOn,
      sharing: sharing ?? this.sharing,
      speaking: speaking ?? this.speaking,
    );
  }
}

class FloatingBubble {
  final String id;
  final String text;
  final Color color;
  FloatingBubble({required this.id, required this.text, required this.color});
}

class GroupCallPage extends StatefulWidget {
  const GroupCallPage({super.key});

  @override
  State<GroupCallPage> createState() => _GroupCallPageState();
}

class _GroupCallPageState extends State<GroupCallPage>
    with TickerProviderStateMixin {
  final List<Participant> _participants = [];
  String myId = 'me';
  bool _muted = false;
  bool _videoOn = true;

  // UI state
  String? focusParticipantId; // if set, show full screen focus
  bool isScreenSharing = false; // if any participant is sharing we adapt layout
  String? screenSharingId;
  Offset myPreviewOffset =
      const Offset(18, 18); // draggable self preview offset
  final List<FloatingBubble> _bubbles = [];
  final GlobalKey _gridKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Seed participants (mock)
    _participants.addAll([
      Participant(id: 'me', name: 'You', muted: false, videoOn: true),
      Participant(id: 'alice', name: 'Alice', muted: false, videoOn: true),
      Participant(id: 'bob', name: 'Bob', muted: true, videoOn: false),
      Participant(id: 'carol', name: 'Carol', muted: false, videoOn: true),
    ]);
    // Simulate a random speaker occasionally
    Timer.periodic(const Duration(seconds: 3), (_) => _randomSpeakPulse());
  }

  void _randomSpeakPulse() {
    if (!mounted) return;
    setState(() {
      for (var p in _participants) {
        p.speaking = false;
      }
      final idx = Random().nextInt(_participants.length);
      _participants[idx].speaking = true;
    });
  }

  // Add participant
  void _showAddParticipants() {
    final candidates = [
      Participant(id: 'dan', name: 'Dan'),
      Participant(id: 'erin', name: 'Erin'),
      Participant(id: 'femi', name: 'Femi'),
      Participant(id: 'gina', name: 'Gina'),
      Participant(id: 'harry', name: 'Harry'),
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
                height: 6,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(6))),
            const SizedBox(height: 12),
            const Text('Add participants',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...candidates.map((c) {
              final already = _participants.any((p) => p.id == c.id);
              return ListTile(
                leading: CircleAvatar(child: Text(c.name[0])),
                title: Text(c.name),
                trailing: ElevatedButton(
                  onPressed: already
                      ? null
                      : () {
                          setState(() => _participants.add(c));
                          Navigator.pop(ctx);
                          // Animate join: briefly highlight
                          _showToast('${c.name} added');
                        },
                  child: Text(already ? 'Added' : 'Add'),
                ),
              );
            }).toList(),
            const SizedBox(height: 12),
            OutlinedButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Close')),
            const SizedBox(height: 8),
          ]),
        );
      },
    );
  }

  // Toggle screen share for me (mock)
  void _toggleScreenShare() {
    setState(() {
      if (isScreenSharing && screenSharingId == myId) {
        isScreenSharing = false;
        screenSharingId = null;
        _showToast('Stopped screen sharing');
      } else {
        // stop others
        for (var p in _participants) {
          p.sharing = (p.id == myId);
        }
        isScreenSharing = true;
        screenSharingId = myId;
        _showToast('You started screen sharing');
      }
    });
  }

  // Example: allow selecting which participant to pin as focus
  void _setFocus(String? id) {
    setState(() {
      if (focusParticipantId == id) {
        focusParticipantId = null;
      } else {
        focusParticipantId = id;
      }
    });
  }

  // Remove participant
  void _removeParticipant(String id) {
    setState(() {
      _participants.removeWhere((p) => p.id == id);
      if (focusParticipantId == id) focusParticipantId = null;
      _showToast('Removed participant');
    });
  }

  // Floating ephemeral messages
  void _sendFloatingMessage(String text) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final color = Colors.primaries[Random().nextInt(Colors.primaries.length)]
        .withOpacity(0.9);
    final bubble = FloatingBubble(id: id, text: text, color: color);
    setState(() => _bubbles.add(bubble));
    // remove after 3s
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() => _bubbles.removeWhere((b) => b.id == id));
    });
  }

  void _toggleMute() {
    setState(() {
      _muted = !_muted;
      final me = _participants.firstWhere((p) => p.id == myId,
          orElse: () => _participants.first);
      me.muted = _muted;
      _showToast(_muted ? 'Muted' : 'Unmuted');
    });
  }

  void _toggleVideo() {
    setState(() {
      _videoOn = !_videoOn;
      final me = _participants.firstWhere((p) => p.id == myId,
          orElse: () => _participants.first);
      me.videoOn = _videoOn;
      _showToast(_videoOn ? 'Camera on' : 'Camera off');
    });
  }

  void _leaveCall() {
    // for mock just pop
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('End Call?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
              child: const Text('End')),
        ],
      ),
    );
  }

  void _showToast(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text), behavior: SnackBarBehavior.floating));
  }

  // Layout helpers
  List<Participant> get _others =>
      _participants.where((p) => p.id != myId).toList();
  Participant get _me => _participants.firstWhere((p) => p.id == myId);

  @override
  Widget build(BuildContext context) {
    // If someone is screen-sharing, prefer that as main view.
    final sharing = _participants.where((p) => p.sharing).toList();
    final hasSharing = sharing.isNotEmpty;
    final sharingParticipant = hasSharing ? sharing.first : null;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background / main area
            Positioned.fill(
                child: _buildMainArea(hasSharing, sharingParticipant)),
            // draggable self-preview
            // Positioned(
            //   left: myPreviewOffset.dx,
            //   top: myPreviewOffset.dy,
            //   child: Draggable(
            //     feedback: _miniTile(_me, highlight: true, size: 120),
            //     childWhenDragging:
            //         Opacity(opacity: 0.25, child: _miniTile(_me)),
            //     onDragEnd: (details) {
            //       final media = MediaQuery.of(context);
            //       final clampedX =
            //           details.offset.dx.clamp(8.0, media.size.width - 120.0);
            //       final clampedY = details.offset.dy.clamp(
            //           media.padding.top + 8.0, media.size.height - 160.0);
            //       setState(() => myPreviewOffset = Offset(clampedX, clampedY));
            //     },
            //     child: GestureDetector(
            //       onDoubleTap: () => _setFocus(myId),
            //       onTap: () => _showParticipantMenu(_me),
            //       child: _miniTile(_me, highlight: true),
            //     ),
            //   ),
            // ),

            // floating chat bubbles overlay
            // Positioned.fill(
            //     child: IgnorePointer(child: _buildFloatingBubbles())),

            // left-top back/info row
            // Positioned(top: 12, left: 12, child: _buildTopLeftInfo()),

            // bottom controls
            // Positioned(
            //     left: 0, right: 0, bottom: 12, child: _buildBottomControls()),

            // floating chat icon (open panel)
            // Positioned(right: 12, bottom: 92, child: _chatButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildTopLeftInfo() {
    return Row(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
            color: Colors.black54, borderRadius: BorderRadius.circular(20)),
        child: Row(children: [
          const Icon(Icons.videocam, size: 18),
          const SizedBox(width: 8),
          Text('${_participants.length} in call',
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ]),
      ),
      const SizedBox(width: 8),
      if (isScreenSharing)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
              color: Colors.orange.shade900.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20)),
          child: const Row(children: [
            Icon(Icons.screen_share, size: 16),
            SizedBox(width: 8),
            Text('Live screen')
          ]),
        ),
    ]);
  }

  Widget _buildMainArea(bool hasSharing, Participant? sharingParticipant) {
    // If focus mode active -> show the focused participant full screen
    if (focusParticipantId != null) {
      final focused = _participants
          .firstWhere((p) => p.id == focusParticipantId, orElse: () => _me);
      return GestureDetector(
        onDoubleTap: () => _setFocus(null),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: Colors.black,
          child: Stack(
            children: [
              Positioned.fill(child: _videoTile(focused, big: true)),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6.0),
                    child: Text(
                        '${focused.name} · ${focused.muted ? 'muted' : 'live'}',
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              // small strip of other participants at bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 120,
                child: SizedBox(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: _participants
                        .where((p) => p.id != focused.id)
                        .map((p) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                                onTap: () => _setFocus(p.id),
                                child:
                                    SizedBox(width: 100, child: _miniTile(p)))))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // If someone is sharing, show sharing area prominently and other tiles in a scrollable strip
    if (hasSharing && sharingParticipant != null) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        color: Colors.black,
        child: Column(
          children: [
            // Shared content takes large portion
            Expanded(
              flex: 6,
              child: Stack(children: [
                Positioned.fill(child: _sharedScreenTile(sharingParticipant)),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Text('${sharingParticipant.name} is presenting',
                          style: const TextStyle(color: Colors.white))),
                ),
              ]),
            ),

            // Scrollable row of participant tiles
            SizedBox(
              height: 160,
              child: ListView(
                key: _gridKey,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(12),
                children: _participants.map((p) {
                  // shrink others slightly while sharing
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onDoubleTap: () => _setFocus(p.id),
                      onTap: () => _showParticipantMenu(p),
                      child: SizedBox(
                          width: 140, child: _videoTile(p, mini: true)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }

    // Default: dynamic grid (scrollable)
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: LayoutBuilder(builder: (context, constraints) {
        // decide number of columns based on width and count
        final width = constraints.maxWidth;
        final count = _participants.length;
        int crossAxisCount;
        if (width > 1000)
          crossAxisCount = 4;
        else if (width > 700)
          crossAxisCount = min(3, max(1, count));
        else if (width > 450)
          crossAxisCount = min(2, max(1, count));
        else
          crossAxisCount = 1;

        // Build a GridView inside a SingleChildScrollView to make it scrollable
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _participants.map((p) {
                final w =
                    (width - (12 * (crossAxisCount + 1))) / crossAxisCount;
                return GestureDetector(
                  onDoubleTap: () => _setFocus(p.id),
                  onTap: () => _showParticipantMenu(p),
                  child: SizedBox(
                      width: w, height: w * 0.65, child: _videoTile(p)),
                );
              }).toList(),
            ),
          ),
        );
      }),
    );
  }

  // Tile for a participant when screen-sharing
  Widget _sharedScreenTile(Participant p) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10)),
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.desktop_windows, size: 56, color: Colors.white24),
          const SizedBox(height: 12),
          Text('${p.name} — Screen',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
              'This is a mock of a shared screen (replace with real stream)',
              style: TextStyle(color: Colors.white70)),
        ]),
      ),
    );
  }

  // Normal video tile: replace Container content with real RTC view later
  Widget _videoTile(Participant p, {bool big = false, bool mini = false}) {
    final border = p.speaking ? 3.5 : 0.5;
    final borderColor = p.speaking ? Colors.greenAccent : Colors.white12;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: border),
      ),
      child: Stack(
        children: [
          // video or placeholder
          Positioned.fill(
            child: p.videoOn
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors
                          .primaries[
                              (p.name.hashCode.abs()) % Colors.primaries.length]
                          .shade700,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(Icons.videocam,
                          size: big ? 84 : 40, color: Colors.white24),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Text(p.name[0],
                            style: const TextStyle(
                                fontSize: 34, fontWeight: FontWeight.bold))),
                  ),
          ),

          // name & status bar
          Positioned(
            left: 8,
            bottom: 8,
            right: 8,
            child: Row(
              children: [
                Expanded(
                    child: Text(p.name,
                        style: const TextStyle(fontWeight: FontWeight.w700))),
                if (p.muted) const Icon(Icons.mic_off, size: 18),
                const SizedBox(width: 6),
                if (p.sharing)
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.orange.shade700,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text('Sharing',
                          style: TextStyle(fontSize: 11))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniTile(Participant p, {bool highlight = false, double size = 96}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: size,
      height: size * 0.62,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        boxShadow: highlight
            ? [
                BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 1)
              ]
            : null,
        border: Border.all(
            color: p.speaking ? Colors.greenAccent : Colors.white12,
            width: p.speaking ? 2.2 : 0.6),
      ),
      child: Stack(children: [
        Positioned.fill(
          child: p.videoOn
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors
                          .primaries[
                              (p.name.hashCode.abs()) % Colors.primaries.length]
                          .shade600,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                      child: Icon(Icons.videocam,
                          size: 28, color: Colors.white24)))
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text(p.name[0],
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)))),
        ),
        Positioned(
            right: 8,
            top: 8,
            child: Row(children: [
              if (p.muted) const Icon(Icons.mic_off, size: 16),
              if (!p.videoOn) const SizedBox(width: 4),
              if (!p.videoOn) const Icon(Icons.videocam_off, size: 16)
            ])),
        Positioned(
            left: 8,
            bottom: 8,
            child: Text(p.name,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w600))),
      ]),
    );
  }

  Widget _buildBottomControls() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.black54, borderRadius: BorderRadius.circular(40)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
            tooltip: 'Mute',
            icon: Icon(_muted ? Icons.mic_off : Icons.mic),
            color: _muted ? Colors.orangeAccent : Colors.white,
            onPressed: _toggleMute,
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Toggle Camera',
            icon: Icon(_videoOn ? Icons.videocam : Icons.videocam_off),
            onPressed: _toggleVideo,
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Add participant',
            icon: const Icon(Icons.person_add),
            onPressed: _showAddParticipants,
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Share screen',
            icon: Icon(isScreenSharing && screenSharingId == myId
                ? Icons.stop_screen_share
                : Icons.screen_share),
            onPressed: _toggleScreenShare,
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(14)),
            onPressed: _leaveCall,
            child: const Icon(Icons.call_end, color: Colors.white),
          ),
        ]),
      ),
    );
  }

  Widget _chatButton() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.white10,
      onPressed: () => _openChatPanel(),
      icon: const Icon(Icons.chat_bubble_outline),
      label: const Text('Chat'),
    );
  }

  Future<void> _openChatPanel() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          minChildSize: 0.25,
          maxChildSize: 0.95,
          builder: (_, controller) {
            final TextEditingController txt = TextEditingController();
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
                Container(
                    height: 6,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(6))),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    controller: controller,
                    children: [
                      const Text('In-call chat',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      ...List.generate(
                          6,
                          (i) => ListTile(
                              leading: CircleAvatar(child: Text('U${i + 1}')),
                              title: Text('This is message #${i + 1}'),
                              subtitle: const Text('In-call note'))),
                    ],
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: TextField(
                        controller: txt,
                        decoration: InputDecoration(
                            hintText: 'Type a short message (it will float)',
                            filled: true,
                            fillColor: Colors.white12,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none))),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (txt.text.trim().isEmpty) return;
                      Navigator.pop(ctx, txt.text.trim());
                    },
                  )
                ]),
                const SizedBox(height: 6),
              ]),
            );
          },
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      _sendFloatingMessage(result);
    }
  }

  // Participant menu (tap tile)
  void _showParticipantMenu(Participant p) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      builder: (_) {
        return SafeArea(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
                leading: CircleAvatar(child: Text(p.name[0])),
                title: Text(p.name),
                subtitle: Text(p.muted ? 'Muted' : 'Live')),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Pin / Focus'),
                onTap: () {
                  Navigator.pop(context);
                  _setFocus(p.id);
                }),
            ListTile(
                leading: const Icon(Icons.volume_off),
                title: Text(p.muted ? 'Unmute' : 'Mute'),
                onTap: () {
                  setState(() {
                    final idx = _participants.indexWhere((x) => x.id == p.id);
                    if (idx >= 0)
                      _participants[idx] =
                          _participants[idx].copyWith(muted: !p.muted);
                  });
                  Navigator.pop(context);
                }),
            ListTile(
                leading: const Icon(Icons.remove_circle_outline),
                title: const Text('Remove from call'),
                onTap: () {
                  Navigator.pop(context);
                  _removeParticipant(p.id);
                }),
            ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Close'),
                onTap: () => Navigator.pop(context)),
          ]),
        );
      },
    );
  }

  Widget _buildFloatingBubbles() {
    // Show bubbles positioned randomly near top-right to bottom-left
    final rnd = Random();
    final List<Widget> positioned = [];
    for (var i = 0; i < _bubbles.length; i++) {
      final b = _bubbles[i];
      final top = 60.0 + (i * 40);
      final left = 60.0 + (rnd.nextDouble() * 40 * (i + 1));
      positioned.add(
        Positioned(
          left: left,
          top: top,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: 1.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: b.color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: b.color.withOpacity(0.4), blurRadius: 8)
                  ]),
              child: Text(b.text, style: const TextStyle(color: Colors.white)),
            ),
          ),
        ),
      );
    }
    return Stack(children: positioned);
  }
}
