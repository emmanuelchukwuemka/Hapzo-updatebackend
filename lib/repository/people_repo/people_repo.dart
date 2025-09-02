import 'package:haptext_api/network/export_network.dart';

class PeopleRepo {
  Future<Response> fetchFriends({page}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.getFriendsUrl(page: page),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> getUsers() async {
    return await ApiMethods.getMethod(
        url: ApiConstants.userProfileBaseUrl,
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> fetchFollowers({page, userId}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.getFollowersUrl(userId: userId, page: page),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> fetchFollowings({page, userId}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.getFollowingsUrl(userId: userId, page: page),
        headers: ApiHeaders.aunthenticatedHeader);
  }
}
