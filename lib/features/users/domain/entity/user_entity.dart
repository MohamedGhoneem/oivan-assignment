class UserEntity {
  final int userId;
  final String displayName;
  final String profileImage;
  final int reputation;
  final String location;
  final int age;
  bool isBookmarked;

  UserEntity({
    required this.userId,
    required this.displayName,
    required this.profileImage,
    required this.reputation,
    required this.location,
    required this.age,
    this.isBookmarked = false,
  });
  UserEntity copyWith({
    int? userId,
    String? displayName,
    String? profileImage,
    int? reputation,
    String? location,
    int? age,
    bool? isBookmarked,
  }) {
    return UserEntity(
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