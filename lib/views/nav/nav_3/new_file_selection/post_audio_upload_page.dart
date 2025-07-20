import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:audioplayers/audioplayers.dart';

class PostAudioUploadPage extends StatefulWidget {
  const PostAudioUploadPage({super.key});

  @override
  PostAudioUploadPageState createState() => PostAudioUploadPageState();
}

class PostAudioUploadPageState extends State<PostAudioUploadPage> {
  File? _selectedAudio;

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  final _audioRecorder = FlutterSoundRecorder();

  Future<void> _uploadAudio() async {
    final audioPicker =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (audioPicker != null) {
      debugPrint('Audio Selected');
      setState(() {
        _selectedAudio = File(audioPicker.files.single.path!);
      });

      setState(() {
        duration = Duration.zero;
        position = Duration.zero;
      });
      await _getDuration();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(title: const AppText(text: 'Audio Upload')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            30.verticalSpace,
            if (_selectedAudio != null) ...[
              Column(children: [
                const AppText(text: 'Audio', color: Colors.white),
                const SizedBox(height: 15.0),
                Slider(
                  min: 0,
                  max: duration.inMilliseconds.toDouble(),
                  value: position.inMilliseconds.toDouble(),
                  onChanged: _onSliderChanged,
                ),
                AppText(
                  text:
                      '${_formatDuration(position)} / ${_formatDuration(duration)}',
                  color: Colors.white,
                ),
                20.verticalSpace,
                Appbutton(
                    width: size.width * 0.6,
                    onTap: isPlaying ? _pauseAudio : _playAudio,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 20.sp, color: Colors.white),
                          10.horizontalSpace,
                          AppText(
                              text: isPlaying ? "Pause Audio" : "Play Audio",
                              color: Colors.white)
                        ])),
                20.verticalSpace,
                Appbutton(
                    isLoading: context.watch<HomeCubit>().state is HomeLoading,
                    width: size.width * 0.6,
                    onTap: () {
                      context
                          .read<HomeCubit>()
                          .createAudioPost(audio: _selectedAudio!);
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload,
                              size: 20.sp, color: Colors.white),
                          10.horizontalSpace,
                          const AppText(
                              text: "Upload File", color: Colors.white)
                        ])),
              ])
            ],
            20.verticalSpace,
            if (_selectedAudio == null) ...[
              Appbutton(
                  width: size.width * 0.6,
                  onTap: _uploadAudio,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fiber_manual_record,
                            size: 20.sp, color: Colors.white),
                        10.horizontalSpace,
                        const AppText(text: "Record", color: Colors.white)
                      ])),
              20.verticalSpace,
              Appbutton(
                  width: size.width * 0.6,
                  onTap: _uploadAudio,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.audio_file,
                            size: 20.sp, color: Colors.white),
                        10.horizontalSpace,
                        const AppText(text: "Select File", color: Colors.white)
                      ])),
            ]
          ],
        ),
      ),
    );
  }

  Future<void> _getDuration() async {
    if (_selectedAudio != null) {
      await _audioPlayer.setSourceUrl(_selectedAudio!.path);
      duration = await _audioPlayer.getDuration() ?? Duration.zero;
      setState(() {});
    }
  }

  Future<void> _playAudio() async {
    if (_selectedAudio != null) {
      await _audioPlayer.play(UrlSource(_selectedAudio!.path));
      _audioPlayer.onPositionChanged.listen((position) {
        setState(() {
          position = position;
        });
      });
      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() {
          position = Duration.zero;
          isPlaying = false;
        });
      });
      setState(() {
        isPlaying = true;
      });
    }
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  void _onSliderChanged(double value) {
    final newPosition = Duration(milliseconds: value.round());
    _audioPlayer.seek(newPosition);
    setState(() {
      position = newPosition;
    });
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
  
    await _audioRecorder.startRecorder(toFile: 'audio.wav');
  }

  Future<void> stopRecording() async {
    await _audioRecorder.stopRecorder();
   
  }
}
