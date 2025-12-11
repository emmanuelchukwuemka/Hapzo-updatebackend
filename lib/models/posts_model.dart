class PostModel {
  List<ResultPostModel>? result;
  dynamic previousPostsData;
  dynamic nextPostsData;

  PostModel({this.result, this.previousPostsData, this.nextPostsData});

  PostModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ResultPostModel>[];
      json['result'].forEach((v) {
        result!.add(ResultPostModel.fromJson(v));
      });
    }
    previousPostsData = json['previous_posts_data'];
    nextPostsData = json['next_posts_data'];
  }
}

class ResultPostModel {
  String? senderId;
  String? postFormat;
  String? textContent;
  String? senderName;
  dynamic imageContent;
  dynamic audioContent;
  dynamic videoContent;
  bool? isReply;
  dynamic previousPostId;
  String? id;
  List taggedUserIds = [];
  String? createdAt;
  String? updatedAt;
  List<CommentModel> comments = [];

  ResultPostModel(
      {this.senderId,
      this.postFormat,
      this.textContent,
      this.imageContent,
      this.audioContent,
      this.videoContent,
      this.senderName,
      this.isReply,
      this.previousPostId,
      this.id,
      this.comments = const [],
      this.taggedUserIds = const [],
      this.createdAt,
      this.updatedAt});

  ResultPostModel.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    postFormat = json['post_format'];
    textContent = json['text_content'];
    imageContent = json['image_content'];
    audioContent = json['audio_content'];
    videoContent = json['video_content'];
    senderName = json['sender_username'];
    isReply = json['is_reply'];
    previousPostId = json['previous_post_id'];
    taggedUserIds = json['tagged_user_ids'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class CommentModel {
  String? senderId;
  String? postFormat;
  String? textContent;
  String? imageContent;
  String? audioContent;
  String? videoContent;
  bool? isReply;
  String? previousPostId;
  String? senderUsername;
  bool? isPublished;
  // Null? scheduledAt;
  // List<Null>? taggedUserIds;
  String? id;
  String? createdAt;
  String? updatedAt;
  // ReactionCounts? reactionCounts;
  int? shareCount;
  // Null? currentUserReaction;

  CommentModel({
    this.senderId,
    this.postFormat,
    this.textContent,
    this.imageContent,
    this.audioContent,
    this.videoContent,
    this.isReply,
    this.previousPostId,
    this.senderUsername,
    this.isPublished,
    // this.scheduledAt,
    // this.taggedUserIds,
    this.id,
    this.createdAt,
    this.updatedAt,
    // this.reactionCounts,
    this.shareCount,
    // this.currentUserReaction
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    postFormat = json['post_format'];
    textContent = json['text_content'];
    imageContent = json['image_content'];
    audioContent = json['audio_content'];
    videoContent = json['video_content'];
    isReply = json['is_reply'];
    previousPostId = json['previous_post_id'];
    senderUsername = json['sender_username'];
    isPublished = json['is_published'];
    // scheduledAt = json['scheduled_at'];
    // if (json['tagged_user_ids'] != null) {
    // 	taggedUserIds = <Null>[];
    // 	json['tagged_user_ids'].forEach((v) { taggedUserIds!.add(new Null.fromJson(v)); });
    // }
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // reactionCounts = json['reaction_counts'] != null ? new ReactionCounts.fromJson(json['reaction_counts']) : null;
    shareCount = json['share_count'];
    // currentUserReaction = json['current_user_reaction'];
  }
}
