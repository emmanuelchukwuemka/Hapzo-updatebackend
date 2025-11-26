import 'package:flutter/foundation.dart';

String bearerToken = '';

class ApiConstants {
  static const String baseUrl = kDebugMode
      ? 'https://hapztext-v2.onrender.com/api/v1'
      : "https://hapztext-v2.onrender.com/api/v1";

  static const String authBaseUrl = "$baseUrl/authentication";
  static const String login = "$authBaseUrl/login/";
  static const String register = "$authBaseUrl/register/";
  static const String requestPasswordReset = "$authBaseUrl/password-reset/";
  static const String verifyPasswordReset = "${requestPasswordReset}confirm/";
  static const String verifyEmailUrl = "$authBaseUrl/verify-email/";
  static const String verifyEmailRequestUrl =
      "$authBaseUrl/verify-email/request/";
  static const String userProfileBaseUrl = "$baseUrl/users";
  static String followUserUrl({userId}) =>
      "$userProfileBaseUrl/follow-request/$userId/";
  static String get createProfileUrl => "$userProfileBaseUrl/profile/create/";
  static String aceeptOrDeclineFollowUrl({requestId}) =>
      "$userProfileBaseUrl/follow-request/handle/$requestId/";
  static String pendingFollowRequestUrl({page}) =>
      "$userProfileBaseUrl/follow-requests/pending/$page/20/";
  static String getFriendsUrl({page}) =>
      "$userProfileBaseUrl/friends/$page/30/";
  static String getUserByIdUrl({userId}) =>
      "$userProfileBaseUrl/profile/$userId/";
  static String searchFriendsUrl({query}) =>
      "$userProfileBaseUrl/search?query=$query&limit=20&offset=1";
  static String usersSearchUrl({query, page}) =>
      "$userProfileBaseUrl/search?query=$query&limit=20&offset=$page";
  static String getFollowersUrl({userId, page}) =>
      "$userProfileBaseUrl/followers/$userId/$page/20/";
  static String getFollowingsUrl({userId, page}) =>
      "$userProfileBaseUrl/followings/$userId/$page/20/";
  static const String postBaseUrl = "$baseUrl/posts/";
  static String postCommentUrl({page, postId}) =>
      "$baseUrl/posts/$postId/replies/$page/30";
  static String fetchNotificationUrl({page}) =>
      "$baseUrl/notifications/$page/20/";
  static String sharePostUrl({postId}) => "$postBaseUrl$postId/share/";
  static String reactPostUrl({postId}) => "$postBaseUrl$postId/react/";
  static String fetchPostUrl({required page, required pageSize}) =>
      "${postBaseUrl}list/$page/$pageSize/";
  static String fetchUserPostUrl(
          {required page, required userId, required pageSize}) =>
      "${postBaseUrl}user/$userId/$page/$pageSize/";
}

class ApiHeaders {
  static Map<String, String> get unaunthenticatedHeader =>
      {'Content-Type': 'application/json', 'Accept': 'application/json'};

  static Map<String, String> get aunthenticatedHeader => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer $bearerToken"
      };
}
