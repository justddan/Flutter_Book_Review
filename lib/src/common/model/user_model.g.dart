// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      profile: json['profile'] as String?,
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      followings: (json['followings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      followersCount: json['followersCount'] as int?,
      followingsCount: json['followingsCount'] as int?,
      reviewCounts: json['reviewCounts'] as int?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'profile': instance.profile,
      'description': instance.description,
      'followers': instance.followers,
      'followings': instance.followings,
      'followersCount': instance.followersCount,
      'followingsCount': instance.followingsCount,
      'reviewCounts': instance.reviewCounts,
    };
