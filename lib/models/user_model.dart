// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String? email;
  String? token;
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? bio;
  String? birthDate;
  String? occupation;
  double? height;
  double? weight;
  String? ethnicity;
  String? relationshipStatus;
  String? user;
  String tagname;
  List<dynamic>? following;
  List<dynamic>? followers;

  UserModel({
    this.email,
    this.token,
    required this.id,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.bio,
    this.birthDate,
    this.occupation,
    this.height,
    this.weight,
    this.ethnicity,
    this.relationshipStatus,
    this.user,
    required this.tagname,
    this.following,
    this.followers,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"] ?? '',
    token: json["token"] ?? '',
    id: json["id"],
    firstName: json["first_name"] ?? '',
    lastName: json["last_name"] ?? '',
    profilePicture: json["profile_picture"] ?? '',
    bio: json["bio"] ?? '',
    birthDate: json["birth_date"] ?? '2000-02-20',
    occupation: json["occupation"] ?? '',
    height: json["height"]?.toDouble() ?? 0.00,
    weight: json["weight"]?.toDouble() ?? 0.00,
    ethnicity: json["ethnicity"] ?? '',
    relationshipStatus: json["relationship_status"] ?? '',
    user: json["user"] ?? '',
    tagname: json["username"],
    // following: List<dynamic>.from(json["following"]!.map((x) => x)),
    // followers: List<dynamic>.from(json["followers"]!.map((x) => x)),
    following: json["following"] != null ? List<dynamic>.from(json["following"].map((x) => x)) : [],
    followers: json["followers"] != null ? List<dynamic>.from(json["followers"].map((x) => x)) : [],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "profile_picture": profilePicture,
    "bio": bio,
    // "birth_date": "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
    "birth_date": birthDate,
    "occupation": occupation,
    "height": height,
    "weight": weight,
    "ethnicity": ethnicity,
    "relationship_status": relationshipStatus,
    "user": user,
    "username": tagname,
    "following": List<dynamic>.from(following!.map((x) => x)),
    "followers": List<dynamic>.from(followers!.map((x) => x)),
  };
}
