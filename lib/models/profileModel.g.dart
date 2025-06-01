// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      id: json['id'] as int,
      birthday: json['birthday'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      userName: json['userName'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String,
      tagName: json['tagName'] as String,
      role: json['role'] as String,
      height: json['height'] as String,
      weight: json['weight'] as String,
      lookingFor: json['lookingFor'] as String,
      ethnicity: json['ethnicity'] as String,
      relationshipStatus: json['relationshipStatus'] as String,
      biography: json['biography'] as String,
      visited: json['visited'] as String,
      location: json['location'] as String,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'userName': instance.userName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'birthday': instance.birthday,
      'tagName': instance.tagName,
      'role': instance.role,
      'height': instance.height,
      'weight': instance.weight,
      'lookingFor': instance.lookingFor,
      'ethnicity': instance.ethnicity,
      'relationshipStatus': instance.relationshipStatus,
      'biography': instance.biography,
      'visited': instance.visited,
      'location': instance.location,
    };
