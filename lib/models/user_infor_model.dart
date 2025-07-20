class UserInfoModel {
  String? id;
  String? email;
  String? username;
  Tokens? tokens;

  UserInfoModel({this.id, this.email, this.username, this.tokens});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['username'] = username;
    if (tokens != null) {
      data['tokens'] = tokens!.toJson();
    }
    return data;
  }
}

class Tokens {
  String? auth;

  Tokens({this.auth});

  Tokens.fromJson(Map<String, dynamic> json) {
    auth = json['auth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auth'] = auth;
    return data;
  }
}
