import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ConfirmAudioUpload extends StatefulWidget {
  const ConfirmAudioUpload({super.key});

  @override
  ConfirmAudioUploadState createState() => ConfirmAudioUploadState();
}

class ConfirmAudioUploadState extends State<ConfirmAudioUpload> {
  File? _selectedAudio;
  String? _audioUrl;
  // AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  Future<void> _uploadAudio() async {
    final audioPicker =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (audioPicker != null) {
      debugPrint('Audio Selected');
      setState(() {
        _selectedAudio = File(audioPicker.files.single.path!);
      });
    }
  }

  // Future<void> _uploadToFirebase() async {
  //   if (_selectedAudio != null) {
  //     final Reference ref =
  //     FirebaseStorage.instance.ref().child('audios/${DateTime.now()}.mp3');
  //     final UploadTask uploadTask = ref.putFile(_selectedAudio!);
  //     final TaskSnapshot snapshot = await uploadTask;
  //
  //     if (snapshot.state == TaskState.success) {
  //       final downloadUrl = await snapshot.ref.getDownloadURL();
  //       setState(() {
  //         _audioUrl = downloadUrl;
  //       });
  //     }
  //   }
  // }

  void _playAudio() {
    if (_audioUrl != null) {
      // audioPlayer.play(_audioUrl!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Upload')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _selectedAudio != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      '',
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  )
                : const SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        '00:00:00',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: Row(
            //     children: [
            //       Text(formatTime(position)),
            //       Text(formatTime(duration - position)),
            //     ],
            //   ),
            // ),
            if (_selectedAudio != null)
              Column(
                children: [
                  const Text(
                    'Audio',
                    // style: TextStyle(fontSize: 20, color: context.theme.primaryColor,),
                  ),
                  const SizedBox(height: 15.0),
                  Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {},
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: AudioPlayerButton(
                      onPressed: _playAudio,
                      icon: Icons.play_arrow,
                      label: 'Play Audio',
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            _selectedAudio != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: AudioPlayerButton(
                      onPressed: () {},
                      // _uploadToFirebase,
                      icon: Icons.cloud_upload,
                      label: 'Upload File',
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: AudioPlayerButton(
                      onPressed: () {},
                      // _uploadToFirebase,
                      icon: Icons.fiber_manual_record,
                      label: 'Record',
                    ),
                  ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: AudioPlayerButton(
                onPressed: _uploadAudio,
                icon: Icons.audio_file,
                label: 'Select File',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AudioPlayerButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const AudioPlayerButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
