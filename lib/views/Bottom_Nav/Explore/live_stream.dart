import 'dart:ui';
import 'package:haptext_api/common/coloors.dart';
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
  bool _isStreamer = false; // Mock toggle for streamer/viewer view
  final List<Map<String, dynamic>> _comments = [
    {"user": "Alex", "text": "Great stream!", "type": "text"},
    {"user": "Sam", "text": "🔊 Voice Note 2s", "type": "voice", "duration": "2s"},
    {"user": "Taylor", "text": "Can you show that again?", "type": "text"},
    {"user": "Chris", "text": "Sent a Rose! 🌹", "type": "gift"},
  ];

  // Recording State
  bool _isRecording = false;
  Duration _recordDuration = Duration.zero;
  Timer? _recordTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Main Video Stream Placeholder
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: const Center(
                child: Icon(Icons.videocam_off, color: Colors.white10, size: 100),
              ),
            ),
          ),

          // 2. Top Bar (Live Badge & Viewer Count)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Coloors.error,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "LIVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isStreamer ? "Your Stream" : "StreamerName",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 18),
                  const SizedBox(width: 4),
                  const Text(
                    "2,543",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  if (_isStreamer) ...[
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {},
                    )
                  ]
                ],
              ),
            ),
          ),

          // 3. Bottom Area (Live Chat & Controls)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Live Chat (Scrollable placeholder)
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      itemCount: _comments.length,
                      itemBuilder: (context, index) {
                        final comment = _comments[index];
                        return _buildCommentItem(comment);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Control Bar / Input Area
                  if (_isStreamer)
                    _buildStreamerControls()
                  else
                    _buildViewerInput(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleRecording() {
    if (_isRecording) {
      _stopAndSendRecording();
    } else {
      _startRecording();
    }
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _recordDuration = Duration.zero;
    });
    _recordTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordDuration += const Duration(seconds: 1);
      });
    });
  }

  void _stopAndSendRecording() {
    _recordTimer?.cancel();
    setState(() {
      _isRecording = false;
      _comments.add({
        "user": "You",
        "text": "🔊 Voice Note ${_formatDuration(_recordDuration)}",
        "type": "voice",
        "duration": _formatDuration(_recordDuration)
      });
    });
  }

  void _cancelRecording() {
    _recordTimer?.cancel();
    setState(() {
      _isRecording = false;
      _recordDuration = Duration.zero;
    });
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget _buildCommentItem(Map<String, dynamic> comment) {
    bool isGift = comment['type'] == 'gift';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${comment['user']}: ",
            style: TextStyle(
              color: isGift ? const Color(0xFFFFD700) : Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: comment['type'] == 'voice'
                ? Row(
                    children: [
                      const Icon(Icons.volume_up, color: Colors.white70, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "[Voice Note ${comment['duration']}]",
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  )
                : Text(
                    comment['text'],
                    style: TextStyle(
                      color: isGift ? const Color(0xFFFFD700) : Colors.white,
                      fontSize: 14,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreamerControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildControlButton(Icons.mic, "Mic"),
        _buildControlButton(Icons.videocam, "Camera"),
        _buildControlButton(Icons.settings, "Settings"),
        _buildControlButton(Icons.stop_circle, "END", color: Coloors.error),
      ],
    );
  }

  Widget _buildViewerInput() {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white.withOpacity(0.1),
                  child: Row(
                    children: [
                      if (_isRecording)
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Icons.circle, color: Colors.red, size: 12),
                              const SizedBox(width: 8),
                              Text(_formatDuration(_recordDuration),
                                  style: const TextStyle(color: Colors.white)),
                              const Spacer(),
                              GestureDetector(
                                onTap: _cancelRecording,
                                child: const Text("Cancel",
                                    style: TextStyle(color: Colors.redAccent)),
                              ),
                            ],
                          ),
                        )
                      else
                        const Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Type message...",
                              hintStyle: TextStyle(color: Colors.white38),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      IconButton(
                        onPressed: _toggleRecording,
                        icon: Icon(
                          _isRecording ? Icons.send : Icons.mic,
                          color: _isRecording ? Colors.cyanAccent : Colors.white70,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        _buildSmallIconAction(Icons.card_giftcard, const Color(0xFFFFD700)),
        const SizedBox(width: 12),
        _buildSmallIconAction(Icons.favorite, Coloors.error),
      ],
    );
  }

  Widget _buildControlButton(IconData icon, String label, {Color? color}) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.1),
          child: Icon(icon, color: color ?? Colors.white),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildSmallIconAction(IconData icon, Color color) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white.withOpacity(0.1),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
