import 'dart:developer';
import 'dart:io';
import 'package:mime/mime.dart';
// import 'package:http_parser/http_parser.dart';
import 'package:haptext_api/network/export_network.dart';

class HomeRepo {
  Future<Response> fetchPost({required int page, String? feedType}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.fetchPostUrl(page: page, pageSize: "20", feedType: feedType),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> fetchUserPost({required int page, userId}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.fetchUserPostUrl(
            page: page, userId: userId, pageSize: "20"),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> commentOnPost(
      {required String postId, required String comment}) async {
    return await ApiMethods.postMethod(
        url: ApiConstants.postBaseUrl,
        body: {
          "is_reply": true,
          "previous_post_id": postId,
          "post_format": "text",
          "text_content": comment
        },
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> fetchPostComment({required String postId}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.postCommentUrl(page: 1, postId: postId),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> sharePost({required String id}) async {
    return await ApiMethods.postMethod(
        url: ApiConstants.sharePostUrl(postId: id),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> reactPost(
      {required String id, required String reaction}) async {
    return await ApiMethods.postMethod(
        url: ApiConstants.reactPostUrl(postId: id),
        body: {"reaction": reaction},
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> fetchNotification({required int page}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.fetchNotificationUrl(page: page),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> createTextPost(
      {required String textContent,
      String? scheduledAt,
      String? taggedUser}) async {
    return await ApiMethods.postMethod(
        url: ApiConstants.postBaseUrl,
        body: {
          "post_format": "text",
          "text_content": textContent,
          "is_reply": false,
          if (scheduledAt != null) "scheduled_at": scheduledAt,
          if (taggedUser != null) "tagged_user_ids": taggedUser,
        },
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<StreamedResponse> createAudioPost(
      {required File audioFile,
      String? scheduledAt,
      String? taggedUser}) async {
    var request = MultipartRequest('POST', Uri.parse(ApiConstants.postBaseUrl));
    log("${lookupMimeType(audioFile.path)} ${audioFile.path}");
    request.files.add(await MultipartFile.fromPath(
        'audio_content', audioFile.path,
        contentType:
            MediaType.parse(lookupMimeType(audioFile.path) ?? 'video/mp4')));
    request.fields.addAll({
      "post_format": "audio",
      if (scheduledAt != null) "scheduled_at": scheduledAt,
      if (taggedUser != null) "tagged_user_ids": taggedUser,
      "is_reply": "false"
    });
    request.headers.addAll(ApiHeaders.aunthenticatedHeader);
    log("Payload ${request.fields.entries} media${request.files.first.field}");
    return await request.send();
  }

  Future<StreamedResponse> createImagePost({
    required List<File> images,
    String? caption,
    String? scheduledAt,
    String? taggedUser,
  }) async {
    var request = MultipartRequest('POST', Uri.parse(ApiConstants.postBaseUrl));

    // Loop through images and add each one
    for (var image in images) {
      request.files.add(await MultipartFile.fromPath('image_files', image.path,
          filename: image.path.split('/').last));
    }

    request.fields.addAll({
      "post_format": "image",
      "text_content": caption ?? '',
      "is_reply": "false",
      if (scheduledAt != null) "scheduled_at": scheduledAt,
      if (taggedUser != null) "tagged_user_ids": taggedUser,
    });

    request.headers.addAll(ApiHeaders.aunthenticatedHeader);
    return await request.send();
  }
  // Future<StreamedResponse> createImagePost(
  //     {required List <File> image,
  //     String? caption,
  //     String? scheduledAt,
  //     String? taggedUser}) async {

  //   var request = MultipartRequest('POST', Uri.parse(ApiConstants.postBaseUrl));
  //   request.files.add(await MultipartFile.fromPath('image_files', image.path,
  //       filename: image.path.split('/').last));
  //   request.fields.addAll({
  //     "post_format": "image",
  //     "text_content": caption ?? '',
  //     "is_reply": "false",
  //     if (scheduledAt != null) "scheduled_at": scheduledAt,
  //     if (taggedUser != null) "tagged_user_ids": taggedUser
  //   });
  //   request.headers.addAll(ApiHeaders.aunthenticatedHeader);
  //   return await request.send();
  // }

  Future<StreamedResponse> createVideoPost(
      {required File videoFile,
      String? caption,
      String? scheduledAt,
      String? taggedUser}) async {
    log("reselt${lookupMimeType(videoFile.path)} ${videoFile.path}");
    var request = MultipartRequest('POST', Uri.parse(ApiConstants.postBaseUrl));
    request.files.add(await MultipartFile.fromPath(
        'video_content', videoFile.path,
        contentType:
            MediaType.parse(lookupMimeType(videoFile.path) ?? 'video/mp4')));
    request.fields.addAll({
      "post_format": "video",
      "text_content": caption ?? '',
      "is_reply": "false",
      if (scheduledAt != null) "scheduled_at": scheduledAt,
      if (taggedUser != null) "tagged_user_ids": taggedUser,
    });
    request.headers.addAll(ApiHeaders.aunthenticatedHeader);
    log("Payload ${request.fields.entries} media${request.files.first.contentType}");
    return await request.send();
  }
}
