import 'package:oivan_assignment/features/users/data/model/user_model.dart';
import '../../domain/entity/get_users_entity.dart';

class GetUsersModel extends GetUsersEntity {
  GetUsersModel({
    super.users,
    super.hasMore,
    super.quotaMax,
    super.quotaRemaining,
  });

  factory GetUsersModel.fromJson(Map<String, dynamic> json) {
    return GetUsersModel(
      users: json['items'] != null
          ? List<UserModel>.from(
        json['items'].map((v) => UserModel.fromJson(v)),
      )
          : null,
      hasMore: json['has_more'],
      quotaMax: json['quota_max'],
      quotaRemaining: json['quota_remaining'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': users?.map((v) => (v as UserModel).toJson()).toList(),
      'has_more': hasMore,
      'quota_max': quotaMax,
      'quota_remaining': quotaRemaining,
    };
  }
}