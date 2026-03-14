import 'package:haptext_api/network/export_network.dart';

class PeopleRepo {
  Future<Response> fetchFriends({page}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.getFriendsUrl(page: page),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> getUsers({required String userId}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.getUserByIdUrl(userId: userId),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> searchFriends({query}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.searchFriendsUrl(query: query),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> searchUsers({query, page}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.usersSearchUrl(query: query, page: page),
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

  Future<Response> fetchProfiles({page, pageSize}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.getProfilesListUrl(page: page, pageSize: pageSize),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> followUser({userId}) async {
    return await ApiMethods.postMethod(
        url: ApiConstants.followUserUrl(userId: userId),
        headers: ApiHeaders.aunthenticatedHeader);
  }
}
