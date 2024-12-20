
import '../../domain/entity/reputation_entity.dart';

class ReputationModel extends ReputationEntity {
  ReputationModel({
    required super.reputationType,
    required super.reputationChange,
    required super.createdAt,
    required super.postId,
  });

  factory ReputationModel.fromJson(Map<String, dynamic> json) {
    return ReputationModel(
      reputationType: json['reputation_history_type'] ?? '',
      reputationChange: json['reputation_change'] ?? 0,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['creation_date'] * 1000),
      postId: json['post_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reputation_history_type': reputationType,
      'reputation_change': reputationChange,
      'creation_date': createdAt.millisecondsSinceEpoch ~/ 1000,
      'post_id': postId,
    };
  }
}