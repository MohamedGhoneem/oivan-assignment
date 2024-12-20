import 'package:oivan_assignment/features/users/domain/entity/user_entity.dart';

class GetUsersEntity {
  List<UserEntity>? users;
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  GetUsersEntity({
    required this.users,
    required this.hasMore,
    required this.quotaMax,
    required this.quotaRemaining,
  });
}