import 'dart:io';
import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/exports.dart';

import 'package:video_player/video_player.dart';

class ConfirmVideoUpload extends StatefulWidget {
  final File? videoFile;

  const ConfirmVideoUpload({super.key, required this.videoFile});

  @override
  State<ConfirmVideoUpload> createState() => _ConfirmVideoUploadState();
}

class _ConfirmVideoUploadState extends State<ConfirmVideoUpload> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _controller = VideoPlayerController.file(widget.videoFile!)
          ..initialize().then((_) {
            setState(() {});
          });
      });
    });
    // _controller = VideoPlayerController.networkUrl(
    //   Uri.parse('https://example.com/video.mp4'),
    // )..initialize().then((_) {
    //     setState(() {});
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: 30,
            //   width: double.infinity,
            //   margin: const EdgeInsets.symmetric(horizontal: 15),
            //   color: Colors.orange,
            //   child: Text(widget.pickedFile.name),
            // ),
            _controller != null && _controller!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _controller!.value.isPlaying
                                ? _controller!.pause()
                                : _controller!.play();
                          });
                        },
                        child: VideoPlayer(_controller!)),
                  )
                : const AppText(text: 'Loading...'),
            20.verticalSpace,
            Appbutton(
              isLoading: context.watch<HomeCubit>().state is HomeLoading,
              label: "Proceed",
              onTap: () {
                context
                    .read<HomeCubit>()
                    .createVideoPost(video: widget.videoFile!);
              },
            )
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
