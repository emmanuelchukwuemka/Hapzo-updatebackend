import 'package:http/http.dart' as http;

class BaseClient {
  var client = http.Client();
  static const String baseUrl = 'https://test-backend-0dhd.onrender.com/social_backend';

  Future<dynamic> get(String api) async {
    var url = Uri.parse(api);
    // var _headers = {
    //   'Authorization': "Bearer sfie328370428387=",
    //   'api_key': "ief873fj38uf38u839898989",
    // };

    var response1 = await client.get(
        url,
        // headers: _headers
    );
    if(response1.statusCode == 200) {
      return response1.body;
    } else {
      print('Failure');
    }
  }

  Future<dynamic> post(String api) async {}

  Future<dynamic> put(String api) async {}

  Future<dynamic> delete(String api) async {}
}