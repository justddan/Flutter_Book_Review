import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final String? profile;
  final String? description;
  final List<String>? followers;
  final List<String>? followings;
  final int? followersCount;
  final int? followingsCount;
  final int? reviewCounts;

  const UserModel({
    this.uid,
    this.name,
    this.email,
    this.profile,
    this.followers,
    this.followings,
    this.description,
    this.followersCount,
    this.followingsCount,
    this.reviewCounts,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toMap() => _$UserModelToJson(this);

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? profile,
    List<String>? followers,
    List<String>? followings,
    String? description,
    int? followersCount,
    int? followingsCount,
    int? reviewCounts,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      profile: profile ?? this.profile,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
      description: description ?? this.description,
      followersCount: followersCount ?? this.followersCount,
      followingsCount: followersCount ?? this.followingsCount,
      reviewCounts: reviewCounts ?? this.reviewCounts,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        profile,
        description,
        followers,
        followings,
        followersCount,
        followingsCount,
        reviewCounts,
      ];
}
