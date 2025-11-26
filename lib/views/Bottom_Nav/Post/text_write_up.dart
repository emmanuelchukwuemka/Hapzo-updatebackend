import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:google_fonts/google_fonts.dart' hide Config;
import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/models/searched_user_model.dart';
import 'package:haptext_api/views/Bottom_Nav/Post/post_audio_upload_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WriteText extends StatefulWidget {
  const WriteText({Key? key}) : super(key: key);
  @override
  State<WriteText> createState() => _WriteTextState();
}

class _WriteTextState extends State<WriteText> {
  final textController = TextEditingController();
  SearchedUserModel? taggedUsers;
  DateTime? _scheduledDate;

  @override
  Widget build(BuildContext context) {
    final watchHome = context.watch<HomeCubit>();
    final size = MediaQuery.sizeOf(context);
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomePostCreated) {
          context.push(RouteName.bottomNav.path);
        }
      },
      child: AbsorbPointer(
        absorbing: watchHome.state is HomeLoading,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                  // color: context.theme.primaryColor,
                  color: Colors.blue[800],
                  child: Center(
                      child: SizedBox(
                    width: size.width * 0.6,
                    child: TextField(
                        controller: textController,
                        maxLines: 2,
                        style: GoogleFonts.jost(
                            fontSize: 16.sp, color: Colors.white),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: 'Write a message',
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            hintStyle: GoogleFonts.jost(
                                fontSize: 16.sp, color: Colors.white))),
                  ))),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () async {
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
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.access_alarms_rounded,
                                  color: Colors.white, size: 22),
                              SizedBox(height: 9.0),
                              AppText(
                                  text: 'Schedule',
                                  color: Colors.white,
                                  fontSize: 15),
                            ],
                          ),
                        ),
                        watchHome.state is HomeLoading
                            ? LoadingAnimationWidget.inkDrop(
                                color: Colors.orange, size: 25.sp)
                            : GestureDetector(
                                onTap: () => context
                                    .read<HomeCubit>()
                                    .createTextPost(
                                        textContent: textController.text
                                            .replaceAll(RegExp(r'\B@\w+'), '')
                                            .trim(),
                                        taggedUser: taggedUsers?.id,
                                        scheduledAt:
                                            _scheduledDate?.toIso8601String()),
                                child: const AppText(
                                    text: 'Done',
                                    color: Colors.white,
                                    fontSize: 18))
                      ])),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(children: [
                        GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => EmojiPicker(
                                  onEmojiSelected: (category, emoji) {
                                    setState(() {
                                      textController.text =
                                          textController.text + emoji.emoji;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  config: Config(
                                      // columns: 7,
                                      emojiViewConfig: EmojiViewConfig(
                                          emojiSizeMax: 32 *
                                              (Platform.isIOS ? 1.30 : 1.0))),
                                ),
                              );
                            },
                            child: Icon(Icons.emoji_emotions_outlined,
                                color: Colors.white, size: 22.sp)),
                        const SizedBox(height: 10),
                        const AppText(
                            text: 'Emoji', color: Colors.white, fontSize: 12),
                      ]),

                      const SizedBox(height: 20),

                      GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return TaggedFriendModal(
                                    onchange: (value) {
                                      if (value.id != null) {
                                        setState(() {
                                          taggedUsers = value;
                                          textController.text =
                                              "${textController.text}\n@${value.username ?? ""}";
                                        });
                                      }
                                    },
                                  );
                                });
                          },
                          child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.person_add,
                                    color: Colors.white, size: 22),
                                SizedBox(height: 10),
                                AppText(
                                    text: 'Tag\npeople',
                                    textAlign: TextAlign.right,
                                    color: Colors.white,
                                    fontSize: 12)
                              ])),
                      const SizedBox(height: 20),
                      const Icon(Icons.star_half_rounded,
                          color: Colors.white, size: 22),
                      const SizedBox(height: 10),
                      const AppText(
                          text: 'Background',
                          color: Colors.white,
                          fontSize: 12),
                      const SizedBox(height: 20),
                      // Icon(Icons.add_business_rounded, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
