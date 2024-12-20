// lib/features/users/domain/entities/reputation_entity.dart
class ReputationEntity {
  final String reputationType;
  final int reputationChange;
  final DateTime createdAt;
  final int postId;

  ReputationEntity({
    required this.reputationType,
    required this.reputationChange,
    required this.createdAt,
    required this.postId,
  });
}