// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/models/searched_user_model.dart';
import 'package:haptext_api/views/Bottom_Nav/Post/post_audio_upload_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CreatePhotoPost extends StatefulWidget {
  const CreatePhotoPost({super.key});

  @override
  State<CreatePhotoPost> createState() => _CreatePhotoPostState();
}

class _CreatePhotoPostState extends State<CreatePhotoPost> {
  final TextEditingController _captionController = TextEditingController();
  DateTime? _scheduledDate;
  bool isRecording = false;
  SearchedUserModel? taggedUsers;

  List<PlatformFile>? pickedFiles;

  Future _selectPhoto() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        pickedFiles = result.files;
      });
    } else {
      debugPrint('Image selecting failed');
    }
  }

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
      });
    }
  }

  void _showFontOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: [
            ListTile(
                title: const AppText(text: "Classic", color: Colors.white),
                onTap: () => Navigator.pop(context)),
            ListTile(
                title:
                    const AppText(text: "Bold & Modern", color: Colors.white),
                onTap: () => Navigator.pop(context)),
            ListTile(
                title: const AppText(text: "Cursive", color: Colors.white),
                onTap: () => Navigator.pop(context))
          ],
        );
      },
    );
  }

  void _showEmojiPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return GridView.count(
          crossAxisCount: 6,
          shrinkWrap: true,
          children: List.generate(30, (index) {
            return Center(
                child: GestureDetector(
                    onTap: () {
                      _captionController.text += "😊";
                      Navigator.pop(context);
                    },
                    child: const AppText(text: "😊", fontSize: 24)));
          }),
        );
      },
    );
  }

  void _deleteScheduledPost() {
    setState(() {
      _scheduledDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final watchHome = context.watch<HomeCubit>();
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) async {
        if (state is HomePostCreated) {
          ToastMessage.showSuccessToast(message: "Photo post created");
          await Future.delayed(const Duration(seconds: 2));
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
                        text: "Upload Photo",
                        fontSize: 18,
                        color: Colors.white),
                    actions: [
                      watchHome.state is HomeLoading
                          ? LoadingAnimationWidget.beat(
                              color: Theme.of(context).primaryColor,
                              size: 20.sp)
                          : IconButton(
                              icon: const Icon(Icons.check),
                              onPressed: () {
                                if (pickedFiles != null) {
                                  context.read<HomeCubit>().createImagePost(
                                      taggedUser: taggedUsers?.id,
                                      scheduledAt:
                                          _scheduledDate?.toIso8601String(),
                                      image: File(
                                          pickedFiles?.firstOrNull?.path ?? ''),
                                      caption: _captionController.text);
                                }
                              })
                    ]),
                body: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppshadowContainer(
                              onTap: _selectPhoto,
                              height: size.height * 0.4,
                              width: double.infinity,
                              color: Colors.grey[850],
                              child: pickedFiles == null
                                  ? const Center(
                                      child: AppText(
                                          text: "Tap to pick Photo ",
                                          fontSize: 16,
                                          color: Colors.white))
                                  : (pickedFiles?.length ?? 0) < 2
                                      ? Center(
                                          child: Image.file(
                                              File(pickedFiles?.first.path ??
                                                  ''),
                                              width: double.infinity,
                                              height: size.height * 0.4,
                                              fit: BoxFit.contain))
                                      : SizedBox(
                                          height: size.height * 0.4,
                                          child: GridView.count(
                                              crossAxisCount: 2,
                                              children: List.generate(
                                                  pickedFiles?.length ?? 0,
                                                  (index) => Image.file(
                                                      File(pickedFiles?[index]
                                                              .path ??
                                                          ''),
                                                      width: double.infinity,
                                                      fit: BoxFit.cover))),
                                        )),
                          const SizedBox(height: 16),

                          // Caption + font + emoji
                          TextField(
                              controller: _captionController,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                  hintText: "Write a caption...",
                                  filled: true,
                                  fillColor: Colors.grey[850],
                                  suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            icon: const Icon(
                                                Icons.emoji_emotions),
                                            onPressed: _showEmojiPicker),
                                        IconButton(
                                            icon: const Icon(Icons.text_fields),
                                            onPressed: _showFontOptions),
                                      ]))),
                          const SizedBox(height: 16),

                          // Tag friends
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
                                      "Scheduled: ${_scheduledDate?.toLocal().toString().split(' ')[0]}",
                                  fontSize: 18,
                                  color: Colors.white),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteScheduledPost(),
                              ),
                            )
                          ],
                          if (taggedUsers != null) ...[
                            const AppText(
                                text: "Tagged user:",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                            const SizedBox(height: 8),
                            ListTile(
                                title: AppText(
                                    text: "@${taggedUsers?.username ?? ''}",
                                    fontSize: 18,
                                    color: Colors.white),
                                trailing: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        taggedUsers = null;
                                      });
                                    }))
                          ]
                        ])))),
      ),
    );
  }
}
