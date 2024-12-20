
import '../../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.userId,
    required super.displayName,
    required super.profileImage,
    required super.reputation,
    required super.location,
    required super.age,
    super.isBookmarked = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'] ?? 0,
      displayName: json['display_name'] ?? '',
      profileImage: json['profile_image'] ?? '',
      reputation: json['reputation'] ?? 0,
      location: json['location'] ?? 'Not specified',
      age: json['age'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'display_name': displayName,
    'profile_image': profileImage,
    'reputation': reputation,
    'location': location,
    'age': age,
  };
}