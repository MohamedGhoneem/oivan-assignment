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
}