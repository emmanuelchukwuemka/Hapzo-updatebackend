// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/bloc/people/cubit/people_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:file_picker/file_picker.dart';
import 'package:haptext_api/models/searched_user_model.dart';
import 'package:haptext_api/widgets/app_bar_widget.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mic_stream_recorder/mic_stream_recorder.dart';

class PostAudioUploadPage extends StatefulWidget {
  const PostAudioUploadPage({Key? key}) : super(key: key);

  @override
  State<PostAudioUploadPage> createState() => _PostAudioUploadPageState();
}

class _PostAudioUploadPageState extends State<PostAudioUploadPage> {
  final MicStreamRecorder _audioRecorder = MicStreamRecorder();

  final AudioPlayer _player = AudioPlayer();

  DateTime? _scheduledDate;
  bool isRecording = false;
  Duration _recordDuration = Duration.zero;
  Timer? _recordTimer;
  SearchedUserModel? taggedUsers;
  String? selectedAudioPath;

  Color selectedColor = Colors.blue.shade100;

  void _selectDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(now.year + 1));
    if (pickedDate != null) {
      setState(() {
        _scheduledDate = pickedDate;
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
    _recordTimer?.cancel();
    super.dispose();
  }

  Future<void> startRecording() async {
    final tempDir = await getTemporaryDirectory();
    final filePath =
        '${tempDir.path}/recording_${DateTime.now().microsecondsSinceEpoch}.aac';
    await _audioRecorder.startRecording(filePath);
    setState(() {
      isRecording = true;
      _recordDuration = Duration.zero;
    });
    _recordTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordDuration += const Duration(seconds: 1);
      });
    });
  }

  Future<void> stopRecording() async {
    _recordTimer?.cancel();
    selectedAudioPath = await _audioRecorder.stopRecording();
    setState(() {
      isRecording = false;
    });
  }

  Future<void> cancelRecording() async {
    _recordTimer?.cancel();
    await _audioRecorder.stopRecording();
    setState(() {
      isRecording = false;
      selectedAudioPath = null;
      _recordDuration = Duration.zero;
    });
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final watchHome = context.watch<HomeCubit>();
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) async {
        if (state is HomePostCreated) {
          ToastMessage.showSuccessToast(message: "Audio post created");
          await Future.delayed(const Duration(seconds: 1));
          context.go(RouteName.bottomNav.path);
        }
      },
      child: Opacity(
        opacity: watchHome.state is HomeLoading ? 0.5 : 1.0,
        child: AbsorbPointer(
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
                    AppshadowContainer(
                        height: 120,
                        color: selectedColor,
                        child: Center(
                            child: isRecording
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.circle,
                                          color: Colors.red, size: 24),
                                      const SizedBox(height: 8),
                                      AppText(
                                          text:
                                              "Recording: ${_formatDuration(_recordDuration)}",
                                          fontSize: 18,
                                          color: Colors.white),
                                      const SizedBox(height: 8),
                                      TextButton(
                                          onPressed: cancelRecording,
                                          child: const AppText(
                                              text: "Cancel",
                                              color: Colors.redAccent))
                                    ],
                                  )
                                : selectedAudioPath == null
                                    ? const AppText(
                                        text: "No audio selected",
                                        fontSize: 18,
                                        color: Colors.white)
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                            AppText(
                                                text: "Recording ready",
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
                                  icon: Icon(
                                      isRecording ? Icons.stop : Icons.mic,
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
                          text: "Tag Friends",
                          fontSize: 18,
                          color: Colors.white),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return TaggedFriendModal(
                                onchange: (value) {
                                  if (value.id != null) {
                                    setState(() {
                                      taggedUsers = value;
                                    });
                                  }
                                },
                              );
                            });
                      },
                    ),
                    const Divider(),

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
                    if (taggedUsers != null) ...[
                      const AppText(
                          text: "Tagged Users",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                      const SizedBox(height: 8),
                      AppshadowContainer(
                        padding: EdgeInsets.all(size.width * 0.04),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                                text: "@${taggedUsers?.username ?? ''}",
                                color: Colors.white),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  taggedUsers = null;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                    // Scheduled posts section

                    if (_scheduledDate != null) ...[
                      const AppText(
                          text: "Scheduled Posts:",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                      const SizedBox(height: 8),
                      ListTile(
                        leading: const Icon(Icons.photo),
                        title: AppText(
                            text:
                                "Scheduled: ${_scheduledDate?.toLocal().toString().split(' ')[0]} ",
                            fontSize: 18,
                            color: Colors.white),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteScheduledPost(),
                        ),
                      )
                    ],

                    const SizedBox(height: 20),
                    const Spacer(),
                    // Post button
                    Appbutton(
                        onTap: () {
                          if (selectedAudioPath != null) {
                            context.read<HomeCubit>().createAudioPost(
                                audio: File(selectedAudioPath!),
                                scheduledAt: _scheduledDate?.toIso8601String(),
                                taggedUser: taggedUsers?.id);
                          }
                        },
                        isLoading: watchHome.state is HomeLoading,
                        width: size.width * 0.6,
                        label: "Post Audio"),
                    40.verticalSpace
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void _deleteScheduledPost() {
    setState(() {
      _scheduledDate = null;
    });
  }
}

class TaggedFriendModal extends StatefulWidget {
  const TaggedFriendModal({super.key, required this.onchange});
  final Function(SearchedUserModel value) onchange;

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
                onTap: () {
                  widget.onchange(watchPeople.searchedUsers[index]);
                  Navigator.pop(context);
                },
                child: AppText(
                    text: "@${watchPeople.searchedUsers[index].username ?? ''}",
                    color: Colors.white),
              );
            }))
          ]))
    ]);
  }
}
