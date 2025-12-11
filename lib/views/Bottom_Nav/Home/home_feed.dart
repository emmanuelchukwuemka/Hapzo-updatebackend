import 'dart:developer' as d;
import 'dart:math';

import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

//----- FULL SCREEN FEED ----------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final post = context.watch<HomeCubit>().posts.result;
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<HomeCubit>().fetchPosts();
        },
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: post?.length ?? 0,
          itemBuilder: (context, index) {
            debugPrint("message ${post?[index].postFormat}");
            return (post?[index].postFormat == "text")
                ? TextPost(post: post?[index] ?? ResultPostModel())
                : (post?[index].postFormat == "audio")
                    ? AudioPost(post: post?[index] ?? ResultPostModel())
                    : (post?[index].postFormat == "video")
                        ? VideoPost(post: post?[index] ?? ResultPostModel())
                        : ImagePost(post: post?[index] ?? ResultPostModel());
          },
        ),
      ),
    );
  }
}

// ---------- POST WRAPPER ----------
class PostWrapper extends StatefulWidget {
  final Widget content;
  final String caption;
  final String username;
  final int viewCount;
  final int tagCount;
  final bool overlayHideEnabled;
  final ResultPostModel post;

  const PostWrapper({
    super.key,
    required this.content,
    required this.caption,
    this.username = "@roman",
    this.viewCount = 1000,
    this.tagCount = 13,
    this.overlayHideEnabled = true,
    required this.post,
  });

  @override
  _PostWrapperState createState() => _PostWrapperState();
}

class _PostWrapperState extends State<PostWrapper>
    with SingleTickerProviderStateMixin {
  bool overlayVisible = true;
  bool showComments = false;
  bool fullScreenMode = false;

  late AnimationController _controller;
  late Animation<double> _shrinkAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _shrinkAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void toggleOverlay() {
    if (!widget.overlayHideEnabled) return;
    setState(() {
      overlayVisible = !overlayVisible;
    });
  }

  void toggleComments() {
    setState(() {
      showComments = !showComments;
      if (showComments)
        _controller.forward();
      else
        _controller.reverse();
    });
  }

  void toggleFullScreen() {
    setState(() {
      fullScreenMode = !fullScreenMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleOverlay,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _shrinkAnimation,
            builder: (context, child) {
              return Align(
                alignment: Alignment.topCenter,
                child: FractionallySizedBox(
                  heightFactor: _shrinkAnimation.value,
                  child: widget.content,
                ),
              );
            },
          ),
          // show corner counts only in fullScreenMode
          if (fullScreenMode)
            Positioned(
              top: 40,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: Colors.black54,
                child: Text('${widget.tagCount} tagged',
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
          if (fullScreenMode)
            Positioned(
              top: 40,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: Colors.black54,
                child: Text('${widget.viewCount} views',
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
          if (overlayVisible)
            _PostOverlay(
              post: widget.post,
              caption: widget.caption,
              username: widget.username,
              viewCount: widget.viewCount,
              tagCount: widget.tagCount,
              onCommentTap: toggleComments,
              onFullScreenTap: toggleFullScreen,
            ),
          if (showComments)
            Align(
              alignment: Alignment.bottomCenter,
              child: CommentSection(onClose: toggleComments),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// ---------- COMMENT SECTION ----------
class CommentSection extends StatelessWidget {
  final VoidCallback onClose;

  const CommentSection({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: onClose,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: 12,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        Colors.primaries[i % Colors.primaries.length],
                    child: Text('U${i + 1}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  title: Text('user_${i + 1}',
                      style: const TextStyle(color: Colors.white)),
                  subtitle: const Text('Nice post!',
                      style: TextStyle(color: Colors.white70)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- POST OVERLAY ----------
class _PostOverlay extends StatelessWidget {
  final String caption;
  final String username;
  final int viewCount;
  final int tagCount;
  final VoidCallback? onCommentTap;
  final VoidCallback? onFullScreenTap;
  final ResultPostModel post;
  const _PostOverlay({
    required this.caption,
    this.username = "@roman",
    this.viewCount = 1000,
    this.tagCount = 13,
    this.onCommentTap,
    this.onFullScreenTap,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF4CAF50)]),
                  ),
                  child: Center(
                    child: Text(
                      username.replaceFirst('@', '')[0].toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: [
                      Text(username,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Text('$viewCount view  $tagCount tagged',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onFullScreenTap,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(Icons.fullscreen, color: Colors.white70),
                  ),
                ),
              ],
            ),
            if (caption.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: AppText(
                      text: caption,
                      color: Colors.white,
                      maxLines: 2,
                      fontSize: 16)),
            Row(
              children: [
                GestureDetector(
                  onTap: () => showDialog(
                      context: context, builder: (_) => ReactionDialog()),
                  child: _buildAction(Icons.favorite_border, '3.5K', () {}),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    context.push(RouteName.commentpage.path, extra: post);
                  },
                  child: _buildAction(Icons.chat_bubble_outline, '789', null),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: AppText(text: 'Saved'))),
                  child: _buildAction(Icons.bookmark_border, 'Save', null),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Shared'))),
                  child: _buildAction(Icons.send_outlined, 'Share', null),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(IconData icon, String label, iconTap) {
    return Row(
      children: [
        GestureDetector(
            onTap: iconTap, child: Icon(icon, color: Colors.white, size: 22)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}

// ---------- REACTION DIALOG ----------
class ReactionDialog extends StatelessWidget {
  final List<Map<String, String>> reactions = [
    {'user': 'Alice', 'reaction': '❤️'},
    {'user': 'Bob', 'reaction': '😂'},
    {'user': 'Charlie', 'reaction': '🔥'},
    {'user': 'Diana', 'reaction': '👍'},
    {'user': 'Eve', 'reaction': '👏'},
    {'user': 'Frank', 'reaction': '😮'},
  ];

  ReactionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87,
      title: const Text('People who reacted',
          style: TextStyle(color: Colors.white)),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: reactions.length,
          itemBuilder: (context, index) {
            final r = reactions[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Colors.primaries[index % Colors.primaries.length],
                child: Text(r['user']![0],
                    style: const TextStyle(color: Colors.white)),
              ),
              title:
                  Text(r['user']!, style: const TextStyle(color: Colors.white)),
              trailing:
                  Text(r['reaction']!, style: const TextStyle(fontSize: 20)),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

// ---------- VIDEO POST ----------
class VideoPost extends StatefulWidget {
  const VideoPost({super.key, required this.post});
  final ResultPostModel post;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    try {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.post.videoContent))
            ..initialize().then((_) {
              setState(() {
                _controller.play();
              });
            });
    } catch (e) {
      d.log("failed video $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return PostWrapper(
        post: widget.post,
        caption: widget.post.textContent ?? '',
        content: _controller.value.isInitialized
            ? GestureDetector(
                // onTap: () {
                //   d.log("ggggggg");
                //   setState(() {
                //     _controller.value.isPlaying
                //         ? _controller.pause()
                //         : _controller.play();
                //   });
                // },
                child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller)))
            : const Center(
                child: Icon(Icons.play_circle_fill,
                    size: 100, color: Colors.white38)),
        username: "@${widget.post.senderName ?? ''}",
        viewCount: 1200,
        tagCount: 34);
  }
}

// ---------- IMAGE POST ----------
class ImagePost extends StatelessWidget {
  const ImagePost({super.key, required this.post});
  final ResultPostModel post;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return PostWrapper(
      post: post,
      caption: post.textContent ?? '',
      content: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.primaries[index % Colors.primaries.length]
                .withValues(alpha: 0.28),
            child: Center(
                child: AppNetwokImage(
                    height: size.height,
                    width: size.width,
                    fit: BoxFit.fill,
                    imageUrl: post.imageContent ?? '')),
          );
        },
      ),
      username: "@${post.senderName}",
      viewCount: 900,
      tagCount: 8,
    );
  }
}

// ---------- AUDIO POST ----------
class AudioPost extends StatefulWidget {
  const AudioPost({super.key, required this.post});
  final ResultPostModel post;
  @override
  AudioPostState createState() => AudioPostState();
}

class AudioPostState extends State<AudioPost>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  late AnimationController _waveController;
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700))
      ..repeat(reverse: true);
  }

  initAudio() async {
    await player.setUrl(widget.post.audioContent);
  }

  void togglePlay() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        player.pause();
        _waveController.repeat(reverse: true);
      } else {
        player.play();
        _waveController.stop();
      }
    });
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PostWrapper(
      post: widget.post,
      caption: widget.post.textContent ?? '',
      content: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF1a1a2e), Color(0xFF16213e), Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: togglePlay,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF4CAF50)]),
                  ),
                  child: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white),
                ),
              ),
              const SizedBox(width: 18),
              Waveform(controller: _waveController),
            ],
          ),
        ),
      ),
      username: "@${widget.post.senderName ?? ''}",
      viewCount: 420,
      tagCount: 3,
    );
  }
}

// ---------- WAVEFORM ----------
class Waveform extends AnimatedWidget {
  Waveform({super.key, required Animation<double> controller})
      : super(listenable: controller);
  final Random _rnd = Random();

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(24, (index) {
        double h = 8 + animation.value * (_rnd.nextInt(36));
        return Container(
          width: 4,
          height: h,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(2)),
        );
      }),
    );
  }
}

// ---------- TEXT POST ----------
class TextPost extends StatelessWidget {
  const TextPost({super.key, required this.post});
  final ResultPostModel post;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // (post.textContent?.length ?? 0) > 30
            //     ? SizedBox(height: size.height * 0.02)
            //     :
            Expanded(child: Container()),
            SizedBox(
                height: (post.textContent?.length ?? 0) > 300
                    ? size.height * 0.5
                    : size.height * 0.1,
                child: SingleChildScrollView(
                    child: AppText(
                        text: post.textContent ?? '',
                        textAlign: TextAlign.center,
                        color: Colors.white,
                        maxLines: 10000,
                        fontSize: 20))),
            Expanded(child: Container()),
            Row(children: [
              AppText(
                  text: '@${post.senderName}',
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              const Spacer(),
              AppText(
                  text:
                      '1k view ${post.taggedUserIds.length > 1 ? "${post.taggedUserIds.length} tagged" : ""}',
                  color: Colors.white70,
                  fontWeight: FontWeight.bold)
            ]),
            const SizedBox(height: 12),
            Row(
              children: [
                GestureDetector(
                    onTap: () => showDialog(
                        context: context, builder: (_) => ReactionDialog()),
                    child: const Row(children: [
                      Icon(Icons.favorite_border, color: Colors.white),
                      SizedBox(width: 6),
                      AppText(text: '3.5K', color: Colors.white)
                    ])),
                const SizedBox(width: 22),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.black87,
                        isScrollControlled: true,
                        builder: (_) => SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: CommentSection(
                                onClose: () => Navigator.of(context).pop())));
                  },
                  child: const Row(children: [
                    Icon(Icons.chat_bubble_outline, color: Colors.white),
                    SizedBox(width: 6),
                    AppText(text: '789', color: Colors.white)
                  ]),
                ),
                const SizedBox(width: 22),
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Saved'))),
                  child: const Row(children: [
                    Icon(Icons.bookmark_border, color: Colors.white),
                    SizedBox(width: 6),
                    AppText(text: 'Save', color: Colors.white)
                  ]),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Shared'))),
                  child: const Row(children: [
                    Icon(Icons.send_outlined, color: Colors.white),
                    SizedBox(width: 6),
                    AppText(text: 'Share', color: Colors.white)
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
