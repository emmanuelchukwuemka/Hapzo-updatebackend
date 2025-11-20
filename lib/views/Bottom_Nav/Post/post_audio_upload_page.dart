import 'dart:async';

import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/bloc/people/cubit/people_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:file_picker/file_picker.dart';
import 'package:haptext_api/widgets/app_bar_widget.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mic_stream_recorder/mic_stream_recorder.dart';
// final watchHome = context.watch<HomeCubit>();
//     return BlocListener<HomeCubit, HomeState>(
//       listener: (context, state) async {
//         if (state is HomePostCreated) {
//           ToastMessage.showSuccessToast(message: "Audio post created");
//           await Future.delayed(const Duration(seconds: 1));
//           context.go(RouteName.bottomNav.path);
//         }
//       },

class PostAudioUploadPage extends StatefulWidget {
  const PostAudioUploadPage({Key? key}) : super(key: key);

  @override
  State<PostAudioUploadPage> createState() => _PostAudioUploadPageState();
}

class _PostAudioUploadPageState extends State<PostAudioUploadPage> {
  final MicStreamRecorder _audioRecorder = MicStreamRecorder();

  final AudioPlayer _player = AudioPlayer();
  final List<DateTime> _scheduledPosts = [];
  DateTime? _scheduledDate;
  bool isRecording = false;
  String? selectedAudioPath;

  Color selectedColor = Colors.blue.shade100;

  void _selectDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (pickedDate != null) {
      setState(() {
        _scheduledDate = pickedDate;
        _scheduledPosts.add(pickedDate);
      });
    }
  }

  Future<void> _selectAudioFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedAudioPath = result.files.single.path;
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

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    await _audioRecorder.startRecording();
    setState(() {
      isRecording = true;
    });
  }

  Future<void> stopRecording() async {
    selectedAudioPath = await _audioRecorder.stopRecording();
    setState(() {
      isRecording = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final watchHome = context.watch<HomeCubit>();
    return AbsorbPointer(
        absorbing: watchHome.state is HomeLoading,
        child: Scaffold(
          appBar: AppBar(
              title: const AppText(
                  text: "Upload Audio Post",
                  fontSize: 18,
                  color: Colors.white)),
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
                        child: selectedAudioPath == null
                            ? const AppText(
                                text: "No audio selected",
                                fontSize: 18,
                                color: Colors.white)
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    AppText(
                                        text: selectedAudioPath!,
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: ElevatedButton.icon(
                              icon: Icon(isRecording ? Icons.stop : Icons.mic,
                                  color: Colors.white),
                              label: AppText(
                                  text: isRecording
                                      ? "Stop Recording"
                                      : "Record VN",
                                  color: Colors.white),
                              onPressed: () {
                                isRecording
                                    ? stopRecording()
                                    : startRecording();
                              })),
                      20.horizontalSpace,
                      Expanded(
                          child: ElevatedButton.icon(
                              icon: const Icon(Icons.audiotrack,
                                  color: Colors.white),
                              label: const AppText(
                                  text: "Select File", color: Colors.white),
                              onPressed: _selectAudioFile))
                    ]),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.tag_faces),
                  title: const AppText(
                      text: "Tag Friends", fontSize: 18, color: Colors.white),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return TaggedFriendModal(
                            onchange: (String value) {},
                          );
                        });
                  },
                ),
                const Divider(),
// Schedule post
                ListTile(
                    leading: const Icon(Icons.schedule),
                    title: AppText(
                        text: _scheduledDate == null
                            ? "Schedule Post"
   : "Scheduled: ${_scheduledDate!.toLocal()}"
                                .split(' ')[0],
                        fontSize: 18,
                        color: Colors.white),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _selectDate),
                const SizedBox(height: 16),

                // Scheduled posts section
                if (_scheduledPosts.isNotEmpty) ...[
                  const AppText(
                      text: "Scheduled Posts:",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                  const SizedBox(height: 8),
                  Column(
                    children: _scheduledPosts.map((date) {
                      return ListTile(
                        leading: const Icon(Icons.photo),
                        title: AppText(
                            text: "Scheduled: ${date.toLocal()}".split(' ')[0],
                            fontSize: 18,
                            color: Colors.white),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteScheduledPost(date),
                        ),
                      );
                    }).toList(),
                  )
                ],
                const SizedBox(height: 20),
                const Spacer(),
                // Post button
                Appbutton(
                    // onTap: () {
                    //   if (selectedAudioPath != null) {
                    //     // context.read<HomeCubit>().createAudioPost(audio: _selectedAudio!);
                    //   }
                    // },
                    isLoading: watchHome.state is HomeLoading,
                    width: size.width * 0.6,
                    onTap: () {
                      // context.read<HomeCubit>().createAudioPost(
                      //       audio = _selectedAudio!,
                      //                               );
                    },
                    label: "Post Audio"),
                40.verticalSpace
              ],
            ),
          ),
        ));
  }

  void _deleteScheduledPost(DateTime date) {
    setState(() {
      _scheduledPosts.remove(date);
    });
  }
}

class TaggedFriendModal extends StatefulWidget {
  const TaggedFriendModal({super.key, required this.onchange});
  final Function(String value) onchange;

  @override
  State<TaggedFriendModal> createState() => _TaggedFriendModalState();
}

class _TaggedFriendModalState extends State<TaggedFriendModal> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 3), () {
      context.read<PeopleCubit>().searchFriends(query: _controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final watchPeople = context.watch<PeopleCubit>();
    return Column(children: [
      20.verticalSpace,
      const AppBarWidget(title: "Tag friends"),
      10.verticalSpace,
      SingleChildScrollView(
          padding: EdgeInsetsGeometry.symmetric(horizontal: size.width * 0.04),
          child: Column(children: [
            InputField(hintText: "Search", controller: _controller),
            30.verticalSpace,
            Column(
                children:
                    List.generate(watchPeople.searchedUsers.length, (index) {
              return AppshadowContainer(
                color: Colors.transparent,
                onTap: () {},
                child: AppText(
                    text: "@${watchPeople.searchedUsers[index].username ?? ''}",
                    color: Colors.white),
              );
            }))
          ]))
    ]);
  }
}
