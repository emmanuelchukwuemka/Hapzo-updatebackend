import 'package:haptext_api/models/posts_model.dart';

class SearchedUserModel {
  String? id;
  String? username;
  String? email;
  String? profilePicture;
  dynamic followerCount;
  dynamic followingCount;
  dynamic mentionCount;
  bool? isEmailVerified;
  String? createdAt;
  String? updatedAt;
  bool following = false;
  SearchedUserProfile? profile;
  List<ResultPostModel> userTextPost = [];
  List<ResultPostModel> userVideoPost = [];
  List<ResultPostModel> userAudioPost = [];
  List<ResultPostModel> userPhotoPost = [];
  String? firstName;
  String? lastName;
  SearchedUserModel(
      {this.id,
      this.username,
      this.email,
      this.following = false,
      this.isEmailVerified,
      this.createdAt,
      this.updatedAt,
      this.profilePicture,
      this.followerCount,
      this.followingCount,
      this.mentionCount,
      this.profile,
      this.userAudioPost = const [],
      this.userPhotoPost = const [],
      this.userTextPost = const [],
      this.userVideoPost = const [],
      this.firstName,
      this.lastName});

  SearchedUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profilePicture = json['profile_picture'];
    followerCount = json['follower_count'];
    mentionCount = json['mention_count'];
    followingCount = json['following_count'];
    email = json['email'];
    isEmailVerified = json['is_email_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class SearchedUserProfile {
  String? userId;
  String? username;
  String? birthDate;
  String? ethnicity;
  String? relationshipStatus;
  String? firstName;
  String? lastName;
  String? bio;
  String? occupation;
  String? profilePicture;
  String? location;
  dynamic height;
  dynamic postCount;
  dynamic followerCount;
  dynamic followingCount;
  dynamic weight;
  String? id;
  String? createdAt;
  String? updatedAt;

  SearchedUserProfile(
      {this.userId,
      this.username,
      this.birthDate,
      this.ethnicity,
      this.relationshipStatus,
      this.firstName,
      this.lastName,
      this.bio,
      this.occupation,
      this.profilePicture,
      this.location,
      this.height,
      this.weight,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.followerCount,
      this.followingCount,
      this.postCount});

  SearchedUserProfile.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    birthDate = json['birth_date'];
    ethnicity = json['ethnicity'];
    postCount = json['post_count'];
    followerCount = json['follower_count'];
    followingCount = json['following_count'];
    relationshipStatus = json['relationship_status'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    bio = json['bio'];
    occupation = json['occupation'];
    profilePicture = json['profile_picture'];
    location = json['location'];
    height = json['height'];
    weight = json['weight'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['birth_date'] = birthDate;
    data['ethnicity'] = ethnicity;
    data['post_count'] = postCount;
    data['follower_count'] = followerCount;
    data['following_count'] = followingCount;
    data['relationship_status'] = relationshipStatus;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['bio'] = bio;
    data['occupation'] = occupation;
    data['profile_picture'] = profilePicture;
    data['location'] = location;
    data['height'] = height;
    data['weight'] = weight;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
