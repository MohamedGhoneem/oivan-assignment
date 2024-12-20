import 'package:oivan_assignment/features/users/data/model/reputation_model.dart';
import 'package:oivan_assignment/features/users/domain/entity/get_reputation_entity.dart';

class GetReputationModel extends GetReputationEntity {
  GetReputationModel({
    super.data,
    super.hasMore,
    super.quotaMax,
    super.quotaRemaining,
  });

  factory GetReputationModel.fromJson(Map<String, dynamic> json) {
    return GetReputationModel(
      data: json['items'] != null
          ? List<ReputationModel>.from(
              json['items'].map((v) => ReputationModel.fromJson(v)),
            )
          : null,
      hasMore: json['has_more'],
      quotaMax: json['quota_max'],
      quotaRemaining: json['quota_remaining'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': data?.map((v) => (v as ReputationModel).toJson()).toList(),
      'has_more': hasMore,
      'quota_max': quotaMax,
      'quota_remaining': quotaRemaining,
    };
  }
}
