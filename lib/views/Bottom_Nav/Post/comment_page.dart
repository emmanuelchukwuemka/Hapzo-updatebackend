import 'dart:math';

import 'package:flutter/material.dart';
import 'package:haptext_api/exports.dart';

class Friend {
  final String id;
  final String name;
  final Color color;
  Friend(this.id, this.name, this.color);
}

/// Comment model (mutable replies + reactions storage)
class Comment {
  final String id;
  final String authorId;
  final String authorName;
  String content;
  final bool isVoiceNote;
  final DateTime timestamp;
  final List<Comment> replies = [];
  final Map<String, List<String>> reactions = {}; // emoji -> list of userIds
  bool bookmarked;

  Comment({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.content,
    this.isVoiceNote = false,
    DateTime? timestamp,
    this.bookmarked = false,
  }) : timestamp = timestamp ?? DateTime.now();
}

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen>
    with SingleTickerProviderStateMixin {
  // Mock friends - for mention search
  final List<Friend> _friends = [
    Friend('f1', 'Ana', Colors.purple),
    Friend('f2', 'Liam', Colors.teal),
    Friend('f3', 'Sora', Colors.indigo),
    Friend('f4', 'Maya', Colors.orange),
    Friend('f5', 'Roman', Colors.cyan),
    Friend('f6', 'Eve', Colors.pinkAccent),
  ];

  // Current user
  final String _meId = 'me';
  final String _meName = 'You';

  // Caption & comments
  final String _caption =
      "This is an example post caption that is intentionally long to demonstrate the See more/See less behavior. "
      "It may contain mentions like @Ana and other text; the UI should show a truncated preview and expand when requested. "
      "Use this space for a descriptive caption — supports See more, shows comment count below, and is kept sleek.";
  bool _showFullCaption = false;

  final List<Comment> _comments = [];

  // Reply tracking: which comment we're replying to (may be nested)
  Comment? _replyTo;

  // Input controller and focus
  final TextEditingController _textController = TextEditingController();
  final FocusNode _inputFocus = FocusNode();

  // Mention suggestion overlay
  List<Friend> _mentionResults = [];
  bool _showMentionList = false;
  String _currentMentionQuery = '';

  // Floating reaction animations
  final List<_FloatingEmoji> _floatingEmojis = [];

  // For collapse logic: track which comment's replies are expanded
  final Set<String> _expandedReplyParents = {};

  // For simplicity, use small emoji set
  final List<String> _emojiSet = ['👍', '❤️', '😂', '🔥', '👏', '😮'];

  // Limit nested depth for visual clarity
  static const int maxDepth = 2;

  // Scroll controller for comments (keeps viewport stable)
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Seed some comments (with nested replies and reactions)
    final c1 = Comment(
        id: 'c1',
        authorId: 'f1',
        authorName: 'Ana',
        content: 'Amazing post! Love this!');
    final c2 = Comment(
        id: 'c2',
        authorId: 'f2',
        authorName: 'Liam',
        content: 'Wow, incredible!');
    final r1 = Comment(
        id: 'r1',
        authorId: 'f3',
        authorName: 'Sora',
        content: 'Totally agree with you!');
    final r2 = Comment(
        id: 'r2', authorId: 'f4', authorName: 'Maya', content: 'same here!');
    c2.replies.add(r1);
    c2.replies.add(r2);
    c2.reactions['👍'] = ['f5', 'f1']; // Roman & Ana
    r1.reactions['❤️'] = ['me'];

    _comments.addAll([c1, c2]);

    // text change listener for mentions
    _textController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onInputChanged);
    _textController.dispose();
    _inputFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Called whenever the input text changes — used to detect "@" mentions
  void _onInputChanged() {
    final text = _textController.text;
    final atIndex = text.lastIndexOf('@');
    if (atIndex >= 0 && atIndex < text.length) {
      final query = text.substring(atIndex + 1);
      // show when user typing mention (no space), or even when empty (show all)
      if (!query.contains(' ')) {
        final q = query.toLowerCase();
        final results = q.isEmpty
            ? _friends.take(6).toList()
            : _friends.where((f) => f.name.toLowerCase().contains(q)).toList();
        setState(() {
          _currentMentionQuery = query;
          _mentionResults = results;
          _showMentionList = results.isNotEmpty;
        });
        return;
      }
    }
    if (_showMentionList) {
      setState(() {
        _showMentionList = false;
        _mentionResults = [];
      });
    }
  }

  // Post comment or reply (voice / text)
  void _postComment({bool isVoice = false}) {
    final text = _textController.text.trim();
    if (!isVoice && text.isEmpty) return;

    final newComment = Comment(
      id: 'c${DateTime.now().millisecondsSinceEpoch}',
      authorId: _meId,
      authorName: _meName,
      content: isVoice ? '[Voice note]' : text,
      isVoiceNote: isVoice,
    );

    setState(() {
      if (_replyTo != null) {
        // compute depth of the target
        final depth = _findDepthOfComment(_replyTo!);
        if (depth >= maxDepth) {
          // attach to nearest allowed parent (depth=maxDepth-1)
          final parent = _findParentAtDepth(_replyTo!, maxDepth - 1);
          if (parent != null) {
            parent.replies.add(newComment);
            _expandedReplyParents.add(parent.id);
          } else {
            // fallback: attach to the target
            _replyTo!.replies.add(newComment);
            _expandedReplyParents.add(_replyTo!.id);
          }
        } else {
          _replyTo!.replies.add(newComment);
          _expandedReplyParents.add(_replyTo!.id);
        }
      } else {
        _comments.insert(0, newComment);
      }

      // reset input, keep focus stable so UI doesn't jump horizontally
      _replyTo = null;
      _textController.clear();
      _showMentionList = false;
      _mentionResults = [];

      // keep input focused so user can continue typing (no layout jump)
      FocusScope.of(context).requestFocus(_inputFocus);
    });
  }

  // Returns depth of a comment starting 0 for top-level
  int _findDepthOfComment(Comment target) {
    int depth = -1;
    void search(List<Comment> list, int d) {
      for (var c in list) {
        if (c.id == target.id) {
          depth = d;
          return;
        }
        if (c.replies.isNotEmpty) {
          search(c.replies, d + 1);
          if (depth >= 0) return;
        }
      }
    }

    search(_comments, 0);
    return depth < 0 ? 0 : depth;
  }

  // Find parent comment at given depth in path to target (returns null if not found)
  Comment? _findParentAtDepth(Comment target, int desiredDepth) {
    List<Comment> path = [];
    bool found = false;
    void dfs(List<Comment> list) {
      for (var c in list) {
        path.add(c);
        if (c.id == target.id) {
          found = true;
          return;
        }
        if (c.replies.isNotEmpty) {
          dfs(c.replies);
          if (found) return;
        }
        path.removeLast();
      }
    }

    dfs(_comments);
    if (!found) return null;
    if (desiredDepth < 0) return null;
    if (desiredDepth >= path.length) return path.first;
    return path[desiredDepth];
  }

  // Toggle reaction for a comment by current user
  void _toggleReaction(Comment comment, String emoji) {
    final list = comment.reactions[emoji] ?? [];
    setState(() {
      if (list.contains(_meId)) {
        list.remove(_meId);
      } else {
        list.add(_meId);
        _spawnFloatingEmoji(emoji);
      }
      if (list.isEmpty) {
        comment.reactions.remove(emoji);
      } else {
        comment.reactions[emoji] = list;
      }
    });
  }

  // Toggle bookmark
  void _toggleBookmark(Comment c) {
    setState(() {
      c.bookmarked = !c.bookmarked;
    });
  }

  // Insert mention at last '@' position
  void _insertMention(Friend f) {
    final text = _textController.text;
    final at = text.lastIndexOf('@');
    String newText;
    if (at >= 0) {
      newText = '${text.substring(0, at)}@${f.name} ';
    } else {
      newText = '$text@${f.name} ';
    }
    setState(() {
      _textController.text = newText;
      _textController.selection =
          TextSelection.fromPosition(TextPosition(offset: newText.length));
      _showMentionList = false;
      _mentionResults = [];
    });
    // keep focus
    FocusScope.of(context).requestFocus(_inputFocus);
  }

  // Show who reacted (bottom sheet)
  void _showWhoReacted(Comment c) {
    final entries = c.reactions.entries.toList();
    final flattened = <Map<String, String>>[];
    for (final e in entries) {
      for (final uid in e.value) {
        final name = (uid == _meId)
            ? _meName
            : (_friends
                .firstWhere((f) => f.id == uid,
                    orElse: () => Friend(uid, uid, Colors.grey))
                .name);
        flattened.add({'id': uid, 'name': name, 'emoji': e.key});
      }
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (_) {
        return SizedBox(
          height: min(360, 60 + flattened.length * 64),
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
                  itemCount: flattened.length,
                  separatorBuilder: (BuildContext context, _) =>
                      const Divider(color: Colors.white10),
                  itemBuilder: (ctx, i) {
                    final who = flattened[i];
                    return ListTile(
                      leading: CircleAvatar(
                          backgroundColor: _avatarColorFor(who['name']!),
                          child: Text(who['name']![0],
                              style: const TextStyle(color: Colors.white))),
                      title: Text(who['name']!,
                          style: const TextStyle(color: Colors.white)),
                      trailing: Text(who['emoji']!,
                          style: const TextStyle(fontSize: 20)),
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

  // Helper: total comment count (including nested)
  int _totalCommentCount() {
    int c = _comments.length;
    for (var com in _comments) {
      c += _countReplies(com);
    }
    return c;
  }

  int _countReplies(Comment c) {
    int total = c.replies.length;
    for (var r in c.replies) {
      total += _countReplies(r);
    }
    return total;
  }

  // Start reply: set target and keep input stable (no jumping)
  void _startReply(Comment target) {
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
    _postComment(isVoice: true);
  }

  // Build a comment tile recursively
  Widget _buildCommentTile(Comment c, {int depth = 0}) {
    final indent = depth * 12.0;
    final reactionsCount =
        c.reactions.entries.fold<int>(0, (p, e) => p + e.value.length);

    final showAllReplies = _expandedReplyParents.contains(c.id);
    final replyCount = c.replies.length;
    final shownReplies =
        showAllReplies ? c.replies : c.replies.take(2).toList();

    return Padding(
      padding: EdgeInsets.only(left: indent, top: 8, bottom: 8, right: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(
              radius: 18,
              backgroundColor: _avatarColorFor(c.authorName),
              child: Text(c.authorName[0],
                  style: const TextStyle(color: Colors.white))),
          const SizedBox(width: 8),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(c.authorName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white)),
                const SizedBox(width: 8),
                Text('· ${_formatTime(c.timestamp)}',
                    style:
                        const TextStyle(color: Colors.white54, fontSize: 12)),
              ]),
              const SizedBox(height: 6),
              // content
              c.isVoiceNote
                  ? const Row(children: [
                      Icon(Icons.play_arrow,
                          size: 18, color: Colors.cyanAccent),
                      SizedBox(width: 8),
                      Text('[Voice note]',
                          style: TextStyle(color: Colors.white))
                    ])
                  : _buildContentWithMentions(c.content),
              const SizedBox(height: 8),
              // actions: reactions preview, reply, bookmark, open emoji picker
              Row(children: [
                if (c.reactions.isNotEmpty)
                  GestureDetector(
                    onTap: () => _showWhoReacted(c),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(24)),
                      child: Row(children: [
                        ...c.reactions.entries.take(3).map((e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Text(e.key,
                                style: const TextStyle(fontSize: 16)))),
                        const SizedBox(width: 6),
                        Text('$reactionsCount',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 12)),
                      ]),
                    ),
                  ),
                const SizedBox(width: 8),
                TextButton(
                    onPressed: () => _startReply(c),
                    child: const Text('Reply',
                        style: TextStyle(color: Colors.cyanAccent))),
                IconButton(
                    onPressed: () => _toggleBookmark(c),
                    icon: Icon(c.bookmarked ? Icons.star : Icons.star_border,
                        color: Colors.yellowAccent)),
                IconButton(
                    onPressed: () => _openEmojiPickerFor(c),
                    icon: const Icon(Icons.emoji_emotions_outlined,
                        color: Colors.white70)),
              ])
            ]),
          )
        ]),
        // replies block
        if (replyCount > 0) const SizedBox(height: 8),
        if (replyCount > 0)
          Padding(
            padding: const EdgeInsets.only(left: 44.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (!showAllReplies && replyCount > 2)
                GestureDetector(
                  onTap: () => setState(() {
                    _expandedReplyParents.add(c.id);
                  }),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('View all $replyCount replies',
                        style: const TextStyle(color: Colors.white54)),
                  ),
                ),
              // shown replies
              ...shownReplies
                  .map((r) => _buildCommentTile(r, depth: depth + 1))
                  .toList(),
              if (showAllReplies && replyCount > 2)
                GestureDetector(
                  onTap: () => setState(() {
                    _expandedReplyParents.remove(c.id);
                  }),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text('Collapse replies',
                        style:
                            TextStyle(color: Colors.white54.withOpacity(0.9))),
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
  void _openEmojiPickerFor(Comment c) {
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
                    _toggleReaction(c, e);
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
    final commentCount = _totalCommentCount();

    // dynamic bottom area height so list padding matches actual space used
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    const baseInputHeight = 72.0; // approximate height of input panel
    final replyBannerHeight = (_replyTo != null) ? 48.0 : 0.0;
    final bottomAreaHeight = baseInputHeight + replyBannerHeight + bottomInset;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F10),
      appBar: AppBar(
        title: const Text('Comments'),
        backgroundColor: Colors.black,
        elevation: 0.5,
      ),
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
                        const CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            child: Text('P',
                                style: TextStyle(color: Colors.white))),
                        const SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppText(
                                  text: 'PosterName',
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
                                              _caption.length < 140
                                          ? _caption
                                          : '${_caption.substring(0, 140)}…',
                                      maxLines: 4,
                                      color: Colors.white70),
                                ),
                              ),
                            ]),
                      ]),
                      const SizedBox(height: 10),
                      Row(children: [
                        Text('$commentCount comments',
                            style: const TextStyle(color: Colors.white54)),
                        const SizedBox(width: 12),
                        InkWell(
                            onTap: () => setState(
                                () => _showFullCaption = !_showFullCaption),
                            child: Text(
                                _showFullCaption ? 'See less' : 'See more',
                                style:
                                    const TextStyle(color: Colors.cyanAccent))),
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
                    _comments.length, (i) => _buildCommentTile(_comments[i]))),
            // Floating emoji widgets
            ..._floatingEmojis.map((f) => _FloatingEmojiWidget(data: f)),
            // Mention overlay (above keyboard / input) - show when typing @
            if (_showMentionList && _mentionResults.isNotEmpty)
              Card(
                color: const Color(0xFF1A1A1C),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 180),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: _mentionResults.length,
                    separatorBuilder: (BuildContext context, _) =>
                        const Divider(height: 1, color: Colors.white10),
                    itemBuilder: (_, i) {
                      final f = _mentionResults[i];
                      return ListTile(
                        leading: CircleAvatar(
                            backgroundColor: f.color,
                            child: Text(f.name[0],
                                style: const TextStyle(color: Colors.white))),
                        title: Text(f.name,
                            style: const TextStyle(color: Colors.white)),
                        onTap: () => _insertMention(f),
                      );
                    },
                  ),
                ),
              ),
            // Bottom input panel (fixed) with reply indicator and stable layout
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(children: [
                      Expanded(
                          child: Text('Replying to ${_replyTo!.authorName}',
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
                        child: const Icon(Icons.mic, color: Colors.cyanAccent)),
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
                                ? 'Reply to ${_replyTo!.authorName}…'
                                : 'Add a comment',
                            hintStyle: const TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: const Color(0xFF161616),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none),
                          ),
                          onSubmitted: (_) => _postComment(isVoice: false))),
                  const SizedBox(width: 8),
                  // quick emoji chooser / send
                  IconButton(
                      onPressed: () => _openQuickEmojiPicker(),
                      icon: const Icon(Icons.emoji_emotions_outlined,
                          color: Colors.white70)),
                  IconButton(
                      onPressed: () => _postComment(isVoice: false),
                      icon: const Icon(Icons.send, color: Colors.cyanAccent)),
                ]),
              ]),
            ),
          ])),
        ]),
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
                      _toggleReaction(_replyTo!, e);
                    } else {
                      final text = _textController.text;
                      final appended = text + e;
                      setState(() => _textController.text = appended);
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
