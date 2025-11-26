import 'dart:math';
import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CommentScreen extends StatefulWidget {
  final ResultPostModel post;
  const CommentScreen({super.key, required this.post});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen>
    with SingleTickerProviderStateMixin {
  // Caption & comments
  bool _showFullCaption = false;

  // Reply tracking: which comment we're replying to (may be nested)
  CommentModel? _replyTo;

  // Input controller and focus
  final TextEditingController _textController = TextEditingController();
  final FocusNode _inputFocus = FocusNode();

  // Floating reaction animations
  final List<_FloatingEmoji> _floatingEmojis = [];

  // For simplicity, use small emoji set
  final List<String> _emojiSet = ['👍', '❤️', '😂', '🔥', '👏', '😮'];

  // Scroll controller for comments (keeps viewport stable)
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchPostComents(post: widget.post);
  }

  @override
  void dispose() {
    _textController.dispose();
    _inputFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Toggle reaction for a comment by current user
  // void _toggleReaction(CommentModel comment, String emoji) {
  //   final list = comment.reactions[emoji] ?? [];
  //   setState(() {
  //     if (list.contains(_meId)) {
  //       list.remove(_meId);
  //     } else {
  //       list.add(_meId);
  //       _spawnFloatingEmoji(emoji);
  //     }
  //     if (list.isEmpty) {
  //       comment.reactions.remove(emoji);
  //     } else {
  //       comment.reactions[emoji] = list;
  //     }
  //   });
  // }

  // Toggle bookmark
  void _toggleBookmark(CommentModel c) {
    setState(() {});
  }

  // Show who reacted (bottom sheet)
  void _showWhoReacted(CommentModel c) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (_) {
        return SizedBox(
          height: min(360, 60 + 2 * 64),
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Reactions',
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.w700))),
              const Divider(color: Colors.white12),
              Expanded(
                child: ListView.separated(
                  itemCount: 2,
                  separatorBuilder: (BuildContext context, _) =>
                      const Divider(color: Colors.white10),
                  itemBuilder: (ctx, i) {
                    return ListTile(
                      leading: CircleAvatar(
                          backgroundColor: _avatarColorFor('name'),
                          child: const AppText(
                              text: "who['name']![0]", color: Colors.white)),
                      title: const AppText(
                          text: "who['name']!", color: Colors.white),
                      trailing:
                          const AppText(text: "who['emoji']!", fontSize: 20),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Color _avatarColorFor(String name) {
    final h = name.hashCode;
    return Colors.primaries[h.abs() % Colors.primaries.length];
  }

  // spawn a subtle floating emoji for visual feedback
  void _spawnFloatingEmoji(String emoji) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final fe = _FloatingEmoji(id: id, emoji: emoji);
    setState(() => _floatingEmojis.add(fe));
    Future.delayed(const Duration(milliseconds: 1400), () {
      setState(() => _floatingEmojis.removeWhere((e) => e.id == id));
    });
  }

  // Start reply: set target and keep input stable (no jumping)
  void _startReply(CommentModel target) {
    setState(() {
      _replyTo = target;
      FocusScope.of(context).requestFocus(_inputFocus);
    });
  }

  // Mock voice recording from input (creates a voice comment)
  Future<void> _recordVoiceNote() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Recording... (mock)')));
    await Future.delayed(const Duration(milliseconds: 900));
  }

  // Build a comment tile recursively
  Widget _buildCommentTile({int depth = 0, required CommentModel comment}) {
    final indent = depth * 12.0;
    // final reactionsCount =
    //     c.reactions.entries.fold<int>(0, (p, e) => p + e.value.length);

    // final showAllReplies = _expandedReplyParents.contains(c.id);
    // final replyCount = c.replies.length;
    // final shownReplies =
    //     showAllReplies ? c.replies : c.replies.take(2).toList();

    return Padding(
      padding: EdgeInsets.only(left: indent, top: 8, bottom: 8, right: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(
              radius: 18,
              backgroundColor: _avatarColorFor("${comment.senderUsername}"),
              child: AppText(
                  text: comment.senderUsername?[0] ?? "0",
                  color: Colors.white)),
          const SizedBox(width: 8),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                AppText(
                    text: comment.senderUsername ?? '',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                const SizedBox(width: 8),
                AppText(
                    text:
                        '· ${_formatTime(DateTime.parse(comment.updatedAt ?? DateTime.now().toString()))}',
                    color: Colors.white54,
                    fontSize: 12),
              ]),
              const SizedBox(height: 6),
              // content
              // c.isVoiceNote
              //     ? const Row(children: [
              //         Icon(Icons.play_arrow,
              //             size: 18, color: Colors.cyanAccent),
              //         SizedBox(width: 8),
              //         AppText(text: '[Voice note]', color: Colors.white)
              //       ])
              //     :
              _buildContentWithMentions(comment.textContent ?? ''),
              const SizedBox(height: 8),
              // actions: reactions preview, reply, bookmark, open emoji picker
              Row(children: [
                // if (c.reactions.isNotEmpty)
                //   GestureDetector(
                //     // onTap: () => _showWhoReacted(c),
                //     child: Container(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 8, vertical: 6),
                //       decoration: BoxDecoration(
                //           color: Colors.white10,
                //           borderRadius: BorderRadius.circular(24)),
                //       child: Row(children: [
                //         ...c.reactions.entries.take(3).map((e) => const Padding(
                //             padding: EdgeInsets.symmetric(horizontal: 3),
                //             child: AppText(text: "e.key", fontSize: 16))),
                //         const SizedBox(width: 6),
                //         const AppText(
                //             text: 'reactionsCount',
                //             color: Colors.white70,
                //             fontSize: 12),
                //       ]),
                //     ),
                //   ),
                const SizedBox(width: 8),
                TextButton(
                    onPressed: () => _startReply(comment),
                    child:
                        const AppText(text: 'Reply', color: Colors.cyanAccent)),
                IconButton(
                    onPressed: () {},
                    // onPressed: () => _toggleBookmark(c),
                    icon: const Icon(
                        // c.bookmarked ? Icons.star :
                        Icons.star_border,
                        color: Colors.yellowAccent)),
                IconButton(
                    onPressed: () {},
                    // onPressed: () => _openEmojiPickerFor(c),
                    icon: const Icon(Icons.emoji_emotions_outlined,
                        color: Colors.white70)),
              ])
            ]),
          )
        ]),
        // replies block
        // if (replyCount > 0) const SizedBox(height: 8),
        // if (replyCount > 0)
        Padding(
          padding: const EdgeInsets.only(left: 44.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // if (!showAllReplies && replyCount > 2)
            GestureDetector(
              onTap: () => setState(() {
                // _expandedReplyParents.add(c.id);
              }),
              child: const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child:
                    AppText(text: 'View all 5 replies', color: Colors.white54),
              ),
            ),
            // shown replies
            // ...shownReplies
            //     .map((r) => _buildCommentTile(r, depth: depth + 1))
            //     .toList(),
            // if (showAllReplies && replyCount > 2)
            GestureDetector(
              onTap: () => setState(() {
                // _expandedReplyParents.remove(c.id);
              }),
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: AppText(
                    text: 'Collapse replies',
                    color: Colors.white54.withValues(alpha: 0.9)),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  // Render content but highlight @mentions (simple highlight for '@Name ')
  Widget _buildContentWithMentions(String content) {
    final parts = <InlineSpan>[];
    final regex = RegExp(r'@[\w]+');
    int last = 0;
    for (final match in regex.allMatches(content)) {
      if (match.start > last) {
        parts.add(TextSpan(
            text: content.substring(last, match.start),
            style: const TextStyle(color: Colors.white)));
      }
      final mention = match.group(0)!;
      parts.add(TextSpan(
          text: mention,
          style: const TextStyle(
              color: Colors.cyanAccent, fontWeight: FontWeight.w600)));
      last = match.end;
    }
    if (last < content.length) {
      parts.add(TextSpan(
          text: content.substring(last),
          style: const TextStyle(color: Colors.white)));
    }
    return RichText(text: TextSpan(children: parts));
  }

  // Emoji picker for a specific comment
  void _openEmojiPickerFor(CommentModel c) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _emojiSet.map((e) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(e, style: const TextStyle(fontSize: 22))),
                );
              }).toList()),
        );
      },
    );
  }

  String _formatTime(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inSeconds < 60) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  @override
  Widget build(BuildContext context) {
    final watchHome = context.watch<HomeCubit>();
    final readHome = context.read<HomeCubit>();
    final size = MediaQuery.sizeOf(context);

    // dynamic bottom area height so list padding matches actual space used
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is PostCommented) {
          _textController.clear();
          _replyTo = null;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFF0F0F10),
        appBar: AppBar(
            title: const AppText(
                text: 'Comments', fontSize: 18, color: Colors.white),
            backgroundColor: Colors.black,
            elevation: 0.5),
        body: SafeArea(
          child: Column(children: [
            // Caption card (poster avatar, caption, See more toggle, comment count)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Card(
                color: const Color(0xFF141416),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          CircleAvatar(
                              backgroundColor: Colors.deepPurple,
                              child: AppText(
                                  text:
                                      '${widget.post.senderName?.substring(0, 1)}',
                                  color: Colors.white)),
                          const SizedBox(width: 10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                    text: widget.post.senderName ?? "",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                                const SizedBox(height: 6),
                                SizedBox(
                                  width: 280,
                                  child: GestureDetector(
                                    onTap: () => setState(() =>
                                        _showFullCaption = !_showFullCaption),
                                    child: AppText(
                                        text: _showFullCaption ||
                                                (widget.post.textContent
                                                            ?.length ??
                                                        0) <
                                                    140
                                            ? widget.post.textContent ?? ""
                                            : '${widget.post.textContent?.substring(0, 140)}…',
                                        maxLines: 4,
                                        color: Colors.white70),
                                  ),
                                ),
                              ]),
                        ]),
                        const SizedBox(height: 10),
                        Row(children: [
                          const AppText(
                              text: '0 comments', color: Colors.white54),
                          const SizedBox(width: 12),
                          InkWell(
                              onTap: () => setState(
                                  () => _showFullCaption = !_showFullCaption),
                              child: AppText(
                                  text: _showFullCaption
                                      ? 'See less'
                                      : 'See more',
                                  color: Colors.cyanAccent)),
                        ]),
                      ]),
                ),
              ),
            ),
            // Comments list

            Expanded(
                child: ListView(children: [
              Column(
                  children: List.generate(
                      widget.post.comments.length,
                      (i) =>
                          _buildCommentTile(comment: widget.post.comments[i]))),
              // Floating emoji widgets
              ..._floatingEmojis.map((f) => _FloatingEmojiWidget(data: f)),
              // // Mention overlay (above keyboard / input) - show when typing @
              // if (_showMentionList && _mentionResults.isNotEmpty)
              //   Card(
              //     color: const Color(0xFF1A1A1C),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //     child: ConstrainedBox(
              //       constraints: const BoxConstraints(maxHeight: 180),
              //       child: ListView.separated(
              //         shrinkWrap: true,
              //         itemCount: _mentionResults.length,
              //         separatorBuilder: (BuildContext context, _) =>
              //             const Divider(height: 1, color: Colors.white10),
              //         itemBuilder: (_, i) {
              //           final f = _mentionResults[i];
              //           return ListTile(
              //             leading: CircleAvatar(
              //                 backgroundColor: f.color,
              //                 child: Text(f.name[0],
              //                     style: const TextStyle(
              //                         color: Colors.white))),
              //             title: Text(f.name,
              //                 style: const TextStyle(color: Colors.white)),
              //             onTap: () => _insertMention(f),
              //           );
              //         },
              //       ),
              //     ),
              //   ),
              // // Bottom input panel (fixed) with reply indicator and stable layout
            ])),
            Container(
                color: const Color(0xFF0B0B0C),
                padding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 10,
                    bottom: bottomInset > 0 ? bottomInset : 12),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  // Reply-to banner (if replying)
                  if (_replyTo != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(children: [
                        Expanded(
                            child: Text(
                                'Replying to ${_replyTo?.senderUsername ?? ''}',
                                style:
                                    const TextStyle(color: Colors.cyanAccent))),
                        GestureDetector(
                            onTap: () => setState(() => _replyTo = null),
                            child:
                                const Icon(Icons.close, color: Colors.white70)),
                      ]),
                    ),

                  if (_replyTo != null) const SizedBox(height: 8),
                  Row(children: [
                    // mic button (voice reply mock)
                    InkWell(
                      onTap: _recordVoiceNote,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: const Color(0xFF161616),
                              borderRadius: BorderRadius.circular(20)),
                          child:
                              const Icon(Icons.mic, color: Colors.cyanAccent)),
                    ),
                    const SizedBox(width: 8),

                    Expanded(
                        child: TextField(
                            controller: _textController,
                            focusNode: _inputFocus,
                            maxLines: null,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                              hintText: _replyTo != null
                                  ? 'Reply to ${_replyTo?.senderUsername ?? ''}…'
                                  : 'Add a comment',
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: const Color(0xFF161616),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none),
                            ),
                            onSubmitted: (_) {})),
                    const SizedBox(width: 8),
                    // quick emoji chooser / send
                    IconButton(
                        onPressed: () => _openQuickEmojiPicker(),
                        icon: const Icon(Icons.emoji_emotions_outlined,
                            color: Colors.white70)),
                    watchHome.state is PostCommenting
                        ? Padding(
                            padding: EdgeInsets.only(right: size.width * 0.02),
                            child: LoadingAnimationWidget.inkDrop(
                                color: Theme.of(context).primaryColor,
                                size: 20))
                        : IconButton(
                            onPressed: () {
                              readHome.commentOnPost(
                                  postId: _replyTo?.id ?? "",
                                  post: _replyTo != null ? null : widget.post,
                                  comment: _textController.text);
                            },
                            icon: const Icon(Icons.send,
                                color: Colors.cyanAccent)),
                  ]),
                ])),
          ]),
        ),
      ),
    );
  }

  // quick emoji sheet (applies to reply target if present, otherwise inserts character)
  void _openQuickEmojiPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _emojiSet.map((e) {
                return GestureDetector(
                  onTap: () {
                    if (_replyTo != null) {
                      Navigator.pop(context);
                      // _toggleReaction(_replyTo!, e);
                    } else {
                      setState(() =>
                          _textController.text = _textController.text + e);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(e, style: const TextStyle(fontSize: 22))),
                );
              }).toList()),
        );
      },
    );
  }
}

/// Floating emoji descriptor
class _FloatingEmoji {
  final String id;
  final String emoji;
  double bottom;
  double left;
  _FloatingEmoji({required this.id, required this.emoji})
      : bottom = 24 + Random().nextDouble() * 30,
        left = 40 + Random().nextDouble() * 200;
}

/// Floating emoji widget (subtle float + fade)
class _FloatingEmojiWidget extends StatefulWidget {
  final _FloatingEmoji data;
  const _FloatingEmojiWidget({required this.data, Key? key}) : super(key: key);

  @override
  State<_FloatingEmojiWidget> createState() => _FloatingEmojiWidgetState();
}

class _FloatingEmojiWidgetState extends State<_FloatingEmojiWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _dy;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400))
      ..forward();
    _dy = Tween<double>(begin: 0, end: -60)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _ctrl, curve: const Interval(0.4, 1.0)));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final startLeft = widget.data.left;
    final startBottom = widget.data.bottom;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (ctx, ch) {
        return Positioned(
          left: startLeft,
          bottom: startBottom + _dy.value,
          child: Opacity(
              opacity: _opacity.value,
              child: Text(widget.data.emoji,
                  style: const TextStyle(fontSize: 28))),
        );
      },
    );
  }
}
