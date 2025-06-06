class UserInfoModel {
  String? id;
  String? username;
  String? email;
  bool? isEmailVerified;
  String? createdAt;
  String? token;

  UserInfoModel(
      {this.id,
      this.username,
      this.email,
      this.isEmailVerified,
      this.createdAt,
      this.token});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    isEmailVerified = json['is_email_verified'];
    createdAt = json['created_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['is_email_verified'] = isEmailVerified;
    data['created_at'] = createdAt;
    data['token'] = token;
    return data;
  }
}
