import 'package:haptext_api/network/export_network.dart';

class HomeRepo {
  Future<Response> fetchPost({required int page}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.fetchPostUrl(page: page, pageSize: "20"),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> createPost(
      {required String postFormat, required String textContent}) async {
    return await ApiMethods.postMethod(
        url: ApiConstants.postBaseUrl,
        body: {
          "post_format": postFormat,
          "text_content": textContent,
          // "image_content": "string",
          // "audio_content": "string",
          // "video_content": "string",
          "is_reply": false,
          // "previous_post_id": "string"
        },
        headers: ApiHeaders.aunthenticatedHeader);
  }
}
