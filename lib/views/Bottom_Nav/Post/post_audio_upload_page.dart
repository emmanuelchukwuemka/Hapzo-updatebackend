// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
// import 'package:haptext_api/exports.dart';
import 'package:flutter_sound/flutter_sound.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:haptext_api/exports.dart';
import 'package:file_picker/file_picker.dart';
import 'package:just_audio/just_audio.dart';
// class PostAudioUploadPage extends StatefulWidget {
//   const PostAudioUploadPage({super.key});

//   @override
//   PostAudioUploadPageState createState() => PostAudioUploadPageState();
// }

// class PostAudioUploadPageState extends State<PostAudioUploadPage> {
//   File? _selectedAudio;

//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//   final _audioRecorder = FlutterSoundRecorder();

//   Future<void> _uploadAudio() async {
//     final audioPicker =
//         await FilePicker.platform.pickFiles(type: FileType.audio);
//     if (audioPicker != null) {
//       debugPrint('Audio Selected');
//       setState(() {
//         _selectedAudio = File(audioPicker.files.single.path!);
//       });

//       setState(() {
//         duration = Duration.zero;
//         position = Duration.zero;
//       });
//       await _getDuration();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     final watchHome = context.watch<HomeCubit>();
//     return BlocListener<HomeCubit, HomeState>(
//       listener: (context, state) async {
//         if (state is HomePostCreated) {
//           ToastMessage.showSuccessToast(message: "Audio post created");
//           await Future.delayed(const Duration(seconds: 1));
//           context.go(RouteName.bottomNav.path);
//         }
//       },
//       child: AbsorbPointer(
//         absorbing: watchHome.state is HomeLoading,
//         child: Scaffold(
//           appBar: AppBar(title: const AppText(text: 'Audio Upload')),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 30.verticalSpace,
//                 if (_selectedAudio != null) ...[
//                   Column(children: [
//                     const AppText(text: 'Audio', color: Colors.white),
//                     const SizedBox(height: 15.0),
//                     Slider(
//                       min: 0,
//                       max: duration.inMilliseconds.toDouble(),
//                       value: position.inMilliseconds.toDouble(),
//                       onChanged: _onSliderChanged,
//                     ),
//                     AppText(
//                       text:
//                           '${_formatDuration(position)} / ${_formatDuration(duration)}',
//                       color: Colors.white,
//                     ),
//                     20.verticalSpace,
//                     Appbutton(
//                         width: size.width * 0.6,
//                         onTap: isPlaying ? _pauseAudio : _playAudio,
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(isPlaying ? Icons.pause : Icons.play_arrow,
//                                   size: 20.sp, color: Colors.white),
//                               10.horizontalSpace,
//                               AppText(
//                                   text:
//                                       isPlaying ? "Pause Audio" : "Play Audio",
//                                   color: Colors.white)
//                             ])),
//                     20.verticalSpace,
//                     Appbutton(
//                         isLoading: watchHome.state is HomeLoading,
//                         width: size.width * 0.6,
//                         onTap: () {
// context.read<HomeCubit>().createAudioPost(
//       audio = _selectedAudio!,
//                               );
//                         },
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.cloud_upload,
//                                   size: 20.sp, color: Colors.white),
//                               10.horizontalSpace,
//                               const AppText(
//                                   text: "Upload File", color: Colors.white)
//                             ])),
//                   ])
//                 ],
//                 20.verticalSpace,
//                 if (_selectedAudio == null) ...[
//                   Appbutton(
//                       width: size.width * 0.6,
//                       onTap: _uploadAudio,
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.fiber_manual_record,
//                                 size: 20.sp, color: Colors.white),
//                             10.horizontalSpace,
//                             const AppText(text: "Record", color: Colors.white)
//                           ])),
//                   20.verticalSpace,
//                   Appbutton(
//                       width: size.width * 0.6,
//                       onTap: _uploadAudio,
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.audio_file,
//                                 size: 20.sp, color: Colors.white),
//                             10.horizontalSpace,
//                             const AppText(
//                                 text: "Select File", color: Colors.white)
//                           ])),
//                 ]
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _getDuration() async {
//     if (_selectedAudio != null) {
//       await _audioPlayer.setSourceUrl(_selectedAudio!.path);
//       duration = await _audioPlayer.getDuration() ?? Duration.zero;
//       setState(() {});
//     }
//   }

//   Future<void> _playAudio() async {
//     if (_selectedAudio != null) {
//       await _audioPlayer.play(UrlSource(_selectedAudio!.path));
//       _audioPlayer.onPositionChanged.listen((position) {
//         setState(() {
//           position = position;
//         });
//       });
//       _audioPlayer.onPlayerComplete.listen((event) {
//         setState(() {
//           position = Duration.zero;
//           isPlaying = false;
//         });
//       });
//       setState(() {
//         isPlaying = true;
//       });
//     }
//   }

//   Future<void> _pauseAudio() async {
//     await _audioPlayer.pause();
//     setState(() {
//       isPlaying = false;
//     });
//   }

//   void _onSliderChanged(double value) {
//     final newPosition = Duration(milliseconds: value.round());
//     _audioPlayer.seek(newPosition);
//     setState(() {
//       position = newPosition;
//     });
//   }

//   String _formatDuration(Duration duration) {
//     final minutes = duration.inMinutes.toString().padLeft(2, '0');
//     final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
//     return '$minutes:$seconds';
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   Future<void> startRecording() async {
//     await _audioRecorder.startRecorder(toFile: 'audio.wav');
//   }

//   Future<void> stopRecording() async {
//     await _audioRecorder.stopRecorder();
//   }
// }

class PostAudioUploadPage extends StatefulWidget {
  const PostAudioUploadPage({Key? key}) : super(key: key);

  @override
  State<PostAudioUploadPage> createState() => _PostAudioUploadPageState();
}

class _PostAudioUploadPageState extends State<PostAudioUploadPage> {
  final _audioRecorder = FlutterSoundRecorder();

  final AudioPlayer _player = AudioPlayer();

  bool isRecording = false;
  String? selectedAudioPath;
  String? selectedAudioName;
  Color selectedColor = Colors.blue.shade100;

  Future<void> _recordVN() async {
    if (isRecording) {
      await _audioRecorder.stopRecorder();
      setState(() {
        isRecording = false;
        // selectedAudioPath = path;
        selectedAudioName = "Recorded Voice Note";
      });
    } else {
      await _audioRecorder.startRecorder(toFile: 'audio.wav');
      setState(() => isRecording = true);
    }
  }

  Future<void> _selectAudioFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedAudioPath = result.files.single.path;
        selectedAudioName = result.files.single.name;
      });
    }
  }

  Future<void> _playPauseAudio() async {
    if (selectedAudioPath == null) return;
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.setFilePath(selectedAudioPath!);
      await _player.play();
    }
    setState(() {});
  }

  void _pickColor(Color color) {
    setState(() => selectedColor = color);
  }

  @override
  void dispose() {
    // _recorder.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const AppText(
              text: "Upload Audio Post", fontSize: 18, color: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Audio container
            AppshadowContainer(
                height: 120,
                color: selectedColor,
                child: Center(
                    child: selectedAudioName == null
                        ? const AppText(
                            text: "No audio selected",
                            fontSize: 18,
                            color: Colors.white)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                AppText(
                                    text: selectedAudioName!,
                                    textAlign: TextAlign.center,
                                    fontSize: 16),
                                IconButton(
                                    icon: Icon(
                                        _player.playing
                                            ? Icons.pause_circle
                                            : Icons.play_circle,
                                        size: 40,
                                        color: Colors.black87),
                                    onPressed: _playPauseAudio)
                              ]))),
            const SizedBox(height: 20),

            // Record & Select buttons
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: ElevatedButton.icon(
                      icon: Icon(isRecording ? Icons.stop : Icons.mic,
                          color: Colors.white),
                      label: AppText(
                          text: isRecording ? "Stop Recording" : "Record VN",
                          color: Colors.white),
                      onPressed: _recordVN)),
              20.horizontalSpace,
              Expanded(
                  child: ElevatedButton.icon(
                      icon: const Icon(Icons.audiotrack, color: Colors.white),
                      label: const AppText(
                          text: "Select File", color: Colors.white),
                      onPressed: _selectAudioFile))
            ]),
            const SizedBox(height: 20),

            // Background color selection
            const Text("Choose Background Color:"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _colorDot(Colors.blue.shade100),
                _colorDot(Colors.green.shade100),
                _colorDot(Colors.purple.shade100),
                _colorDot(const Color.fromRGBO(255, 224, 178, 1)),
                _colorDot(Colors.red.shade100),
              ],
            ),
            const Spacer(),

            // Post button
            Appbutton(
                onTap: () {
                  if (selectedAudioPath != null) {
                    // context.read<HomeCubit>().createAudioPost(audio: _selectedAudio!);
                  }
                },
                label: "Post Audio"),
            40.verticalSpace
          ],
        ),
      ),
    );
  }

  Widget _colorDot(Color color) {
    return GestureDetector(
      onTap: () => _pickColor(color),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: color,
        child: selectedColor == color
            ? const Icon(Icons.check, color: Colors.white)
            : null,
      ),
    );
  }
}
