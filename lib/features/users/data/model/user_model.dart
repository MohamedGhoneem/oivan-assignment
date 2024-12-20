
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
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      userId: entity.userId,
      displayName: entity.displayName,
      profileImage: entity.profileImage,
      location: entity.location,
      reputation: entity.reputation,
      isBookmarked: entity.isBookmarked,
      age: entity.age,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      displayName: displayName,
      profileImage: profileImage,
      location: location,
      reputation: reputation,
      isBookmarked: isBookmarked,
      age: age,
    );
  }
  @override
  String toString() {
    return 'UserModel(userId: $userId, displayName: $displayName, isBookmarked: $isBookmarked)';
  }

  // Add copy with method
  @override
  UserModel copyWith({
    int? userId,
    String? displayName,
    String? profileImage,
    int? reputation,
    String? location,
    int? age,
    bool? isBookmarked,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      profileImage: profileImage ?? this.profileImage,
      reputation: reputation ?? this.reputation,
      location: location ?? this.location,
      age: age ?? this.age,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}