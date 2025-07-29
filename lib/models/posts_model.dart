class PostModel {
  List<ResultModel>? result;
  dynamic previousPostsData;
  dynamic nextPostsData;

  PostModel({this.result, this.previousPostsData, this.nextPostsData});

  PostModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ResultModel>[];
      json['result'].forEach((v) {
        result!.add(ResultModel.fromJson(v));
      });
    }
    previousPostsData = json['previous_posts_data'];
    nextPostsData = json['next_posts_data'];
  }
}

class ResultModel {
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
  String? createdAt;
  String? updatedAt;

  ResultModel(
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
      this.createdAt,
      this.updatedAt});

  ResultModel.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    postFormat = json['post_format'];
    textContent = json['text_content'];
    imageContent = json['image_content'];
    audioContent = json['audio_content'];
    videoContent = json['video_content'];
    senderName = json['sender_username'];
    isReply = json['is_reply'];
    previousPostId = json['previous_post_id'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
