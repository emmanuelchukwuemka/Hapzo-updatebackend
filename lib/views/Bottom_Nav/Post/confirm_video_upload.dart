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
  final captionController = TextEditingController();
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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final watchHome = context.watch<HomeCubit>();
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) async {
        if (state is HomePostCreated) {
           ToastMessage.showSuccessToast(message: "Video post created");
          await Future.delayed(const Duration(seconds: 2));
          context.go(RouteName.bottomNav.path);
        }
      },
      child: AbsorbPointer(
        absorbing: watchHome.state is HomeLoading,
        child: Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Column(
              children: [
                20.verticalSpace,
                InputField(
                    title: "Vide caption (optional)",
                    controller: captionController),
                20.verticalSpace,
                _controller != null && _controller!.value.isInitialized
                    ? SizedBox(
                        height: size.height * 0.7,
                        width: size.width,
                        child: AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _controller!.value.isPlaying
                                        ? _controller!.pause()
                                        : _controller!.play();
                                  });
                                },
                                child: VideoPlayer(_controller!))),
                      )
                    : const AppText(text: 'Loading...'),
                20.verticalSpace,
                Appbutton(
                    isLoading: context.watch<HomeCubit>().state is HomeLoading,
                    label: "Proceed",
                    onTap: () {
                      watchHome.createVideoPost(
                          video: widget.videoFile!,
                          caption: captionController.text);
                    })
              ],
            ),
          ),
        )),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
