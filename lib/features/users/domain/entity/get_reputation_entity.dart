import 'package:oivan_assignment/features/users/domain/entity/reputation_entity.dart';

class GetReputationEntity {
  List<ReputationEntity>? data;
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  GetReputationEntity({
    required this.data,
    required this.hasMore,
    required this.quotaMax,
    required this.quotaRemaining,
  });
}