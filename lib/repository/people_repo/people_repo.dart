import 'package:haptext_api/network/export_network.dart';

class PeopleRepo {
  Future<Response> fetchFriends({page}) async {
    return await ApiMethods.getMethod(
        url: ApiConstants.getFriendsUrl(page: page),
        headers: ApiHeaders.aunthenticatedHeader);
  }
}
