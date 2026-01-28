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
      this.userVideoPost = const []});

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
}
