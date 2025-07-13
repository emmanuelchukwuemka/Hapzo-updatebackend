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
  static const String postBaseUrl = "$baseUrl/posts/";
  static String fetchPostUrl({required page, required pageSize}) =>
      "${postBaseUrl}list/$page/$pageSize/";
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
