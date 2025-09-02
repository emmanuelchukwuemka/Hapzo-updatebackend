import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/common/coloors.dart';
import 'package:haptext_api/common/utils.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final post = context.watch<HomeCubit>().posts.result;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: const AppText(
                text: '  HapzText',
                color: Colors.white,
                fontWeight: FontWeight.bold),
            // backgroundColor: context.theme.appBarColor,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    //  context.read<HomeCubit>()
                    context.push(RouteName.bottomNav.path);
                  },
                  icon: const Icon(Icons.chat),
                  iconSize: 22,
                  color: context.theme.primaryColor),
              const SizedBox(width: 3),
              IconButton(
                  onPressed: () {
                    context.read<HomeCubit>().fetchPosts();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => const Notifications(),
                    //   ),
                    // );
                  },
                  icon: const Icon(Icons.notifications),
                  iconSize: 22),
              const SizedBox(width: 5),
            ],
            flexibleSpace: ClipPath(
              // clipper: MyCustomClipperForAppBar(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFFC203),
                      Color(0xFFFD8502),
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: PageView.builder(
          scrollDirection: Axis.vertical,
          // padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          itemCount: post?.length ?? 0,
          itemBuilder: (context, index) {
            return PostContentWidget(
                size: size,
                post: post,
                index: index); // Replace Container with your actual widget
          },
        ));
  }
}

class PostContentWidget extends StatefulWidget {
  const PostContentWidget(
      {super.key, required this.size, required this.post, required this.index});

  final Size size;
  final int index;
  final List<ResultModel>? post;

  @override
  State<PostContentWidget> createState() => _PostContentWidgetState();
}

class _PostContentWidgetState extends State<PostContentWidget> {
  VideoPlayerController? _videoPlayerController;
  bool _isVideoInitialized = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // Initialize video player only if it's a video post
    _initializeVideoPlayer(
      widget.post?[widget.index].videoContent,
      widget.post?[widget.index].postFormat,
    );
    // Remove WidgetsBinding.instance.addPersistentFrameCallback here.
    // It's not the correct place for controller initialization.
  }

  // Helper method to initialize the video player
  Future<void> _initializeVideoPlayer(
      String? videoUrl, String? postFormat) async {
    // Dispose any existing controller before creating a new one
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
      _videoPlayerController = null;
    }

    _isVideoInitialized = false; // Reset initialization flag

    if (postFormat?.toLowerCase() == "video" &&
        videoUrl != null &&
        videoUrl.isNotEmpty) {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      try {
        await _videoPlayerController!.initialize();
        _videoPlayerController!.setLooping(true);
        _videoPlayerController!.setVolume(0.0); // Start muted

        if (mounted) {
          setState(() {
            _isVideoInitialized = true;
          });
        }
        log("Video initialized for URL: $videoUrl, Status: ${_videoPlayerController!.value.isInitialized}");
      } catch (e) {
        log("Error initializing video for URL: $videoUrl, Error: $e");
        if (mounted) {
          setState(() {
            _isVideoInitialized = false; // Mark as not initialized on error
          });
        }
      }
    } else {
      // If it's not a video post or content is null/empty, ensure flag is false
      if (mounted) {
        setState(() {
          _isVideoInitialized = false;
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant PostContentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldVideoContent = oldWidget.post?[oldWidget.index].videoContent;
    final newVideoContent = widget.post?[widget.index].videoContent;
    final oldPostFormat =
        oldWidget.post?[oldWidget.index].postFormat?.toLowerCase();
    final newPostFormat = widget.post?[widget.index].postFormat?.toLowerCase();

    // Re-initialize video player if the video content or format changes
    if (newPostFormat == "video" && newVideoContent != oldVideoContent) {
      _initializeVideoPlayer(newVideoContent, newPostFormat);
    } else if (newPostFormat != "video" && oldPostFormat == "video") {
      // If it transitioned from video to something else, dispose the video controller
      if (_videoPlayerController != null) {
        _videoPlayerController!.dispose();
        _videoPlayerController = null;
        if (mounted) {
          setState(() {
            _isVideoInitialized = false;
          });
        }
      }
    }
    // Add logic here if you need to control video play/pause based on widget.play
    // (if you introduce a 'play' prop to this widget from a PageView parent)
  }

  @override
  Widget build(BuildContext context) {
    return AppshadowContainer(
      margin: EdgeInsets.symmetric(
          vertical: widget.size.width * 0.02,
          horizontal: widget.size.width * 0.04),
      padding: EdgeInsets.all(widget.size.width * 0.04),
      color: context.theme.appBarColor,
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
              text: widget.post?[widget.index].senderName ?? '',
              fontWeight: FontWeight.w600,
              color: Colors.deepOrangeAccent),
          AppText(
              text: UsefulMethods.formatDate(
                  widget.post?[widget.index].createdAt ??
                      '2025-07-13T18:56:55.550942Z'),
              color: Colors.deepOrangeAccent),
          20.verticalSpace,
          AppshadowContainer(
              onTap: () {
                if (widget.post?[widget.index].postFormat == "video") {
                  setState(() {
                    _videoPlayerController?.value.isPlaying ?? false
                        ? _videoPlayerController?.pause()
                        : _videoPlayerController?.play();
                  });
                }
              },
              height: widget.size.height * 0.48,
              padding: EdgeInsets.all(widget.size.width * 0.04),
              border: true,
              color: Colors.transparent,
              borderColor: Colors.white.withAlpha(50),
              child: widget.post?[widget.index].postFormat?.toLowerCase() ==
                      'text'
                  ? AppText(
                      text: widget.post?[widget.index].textContent ?? '',
                      color: Colors.white,
                      maxLines: 150)
                  : widget.post?[widget.index].postFormat?.toLowerCase() ==
                          'video'
                      ? _isVideoInitialized == false
                          ? const CircularProgressIndicator()
                          : _videoPlayerController?.value.hasError ?? false
                              ? Icon(Icons.error_outline,
                                  size: 25.sp, color: Coloors.orangeDark)
                              : AspectRatio(
                                  aspectRatio: _videoPlayerController
                                          ?.value.aspectRatio ??
                                      0,
                                  child: VideoPlayer(_videoPlayerController!))
                      : widget.post?[widget.index].postFormat?.toLowerCase() ==
                              "image"
                          ? AppNetwokImage(
                              height: widget.size.height * 0.55,
                              width: widget.size.width,
                              imageUrl: widget.post?[widget.index].imageContent)
                          : GestureDetector(
                              onTap: () async {
                                if (_isPlaying) {
                                  await _audioPlayer.pause();
                                  setState(() {
                                    _isPlaying = false;
                                  });
                                } else {
                                  await _audioPlayer.play(UrlSource(
                                      widget.post?[widget.index].audioContent));
                                  setState(() {
                                    _isPlaying = true;
                                  });
                                }
                              },
                              child: Column(
                                children: [
                                  AppNetwokImage(
                                      height: widget.size.height * 0.35,
                                      width: widget.size.width,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "https://thumbs.dreamstime.com/b/music-round-frame-circular-sound-wave-rainbow-dot-patterns-isolated-black-background-border-musician-logo-template-251707800.jpg"),
                                  Icon(
                                      _isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 60.sp,
                                      color: Colors.orange)
                                ],
                              ),
                            )),
          20.verticalSpace,
          Row(children: [
            AppNetwokImage(
                height: widget.size.width * 0.1,
                fit: BoxFit.fill,
                radius: widget.size.width * 0.9,
                width: widget.size.width * 0.1,
                imageUrl: ""),
            5.horizontalSpace,
            Appbutton(
                label: "Your Friend",
                width: widget.size.width * 0.23,
                labelSize: 12,
                height: widget.size.width * 0.09,
                buttonColor: Colors.green)
          ]),
          10.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: widget.size.width * 0.67,
                  child: AppText(
                      text: widget.post?[widget.index].textContent ?? "",
                      maxLines: 3,
                      color: Colors.white)),
              const Spacer(),
              Column(
                children: [
                  Row(children: [
                    Icon(Icons.favorite,
                        color: Colors.deepOrangeAccent, size: 25.sp),
                    10.horizontalSpace,
                    Icon(Icons.mode_comment_sharp,
                        color: Colors.deepOrangeAccent, size: 25.sp)
                  ]),
                  10.verticalSpace,
                  Row(children: [
                    Icon(Icons.reply,
                        color: Colors.deepOrangeAccent, size: 25.sp),
                    10.horizontalSpace,
                    Icon(Icons.download,
                        color: Colors.deepOrangeAccent, size: 25.sp)
                  ]),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}
