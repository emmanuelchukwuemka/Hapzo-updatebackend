import 'dart:developer';
import 'dart:io';

import 'package:haptext_api/network/export_network.dart';

class HomeRepo {
  Future<Response> fetchPost({required int page}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.fetchPostUrl(page: page, pageSize: "20"),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> createTextPost({required String textContent}) async {
    return await ApiMethods.postMethod(
        url: ApiConstants.postBaseUrl,
        body: {
          "post_format": "text",
          "text_content": textContent,
          "is_reply": false
        },
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<StreamedResponse> createAudioPost({required File audioFile}) async {
    var request = MultipartRequest('POST', Uri.parse(ApiConstants.postBaseUrl));
    request.files.add(MultipartFile.fromString(
        'audio_content', audioFile.uri.toFilePath(),
        filename: audioFile.path.split('/').last));
    request.fields.addAll({"post_format": "audio", "is_reply": "false"});
    request.headers.addAll(ApiHeaders.aunthenticatedHeader);
    log("Payload ${request.fields.entries} media${request.files.first.field}");
    return await request.send();
  }

  Future<StreamedResponse> createImagePost({required File image}) async {
    var request = MultipartRequest('POST', Uri.parse(ApiConstants.postBaseUrl));
    request.files.add(await MultipartFile.fromPath('image_content', image.path,
        filename: image.path.split('/').last));
    request.fields.addAll({"post_format": "image", "is_reply": "false"});
    request.headers.addAll(ApiHeaders.aunthenticatedHeader);
    log("Payload ${request.fields.entries} media${request.files.first.field}");
    return await request.send();
  }

  Future<StreamedResponse> createVideoPost({required File videoFile}) async {
    var request = MultipartRequest('POST', Uri.parse(ApiConstants.postBaseUrl));
    request.files.add(MultipartFile.fromString(
        'video_content', videoFile.uri.path,
        filename: videoFile.path.split('/').last));
    request.fields.addAll({"post_format": "video", "is_reply": "false"});
    request.headers.addAll(ApiHeaders.aunthenticatedHeader);
    log("Payload ${request.fields.entries} media${request.files.first.field}");
    return await request.send();
  }
}
