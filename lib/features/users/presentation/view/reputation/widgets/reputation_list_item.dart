import 'package:flutter/material.dart';
import 'package:oivan_assignment/features/users/domain/entity/reputation_entity.dart';

class ReputationListItem extends StatelessWidget {
  final ReputationEntity reputation;

  const ReputationListItem({
    super.key,
    required this.reputation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getReputationColor(reputation.reputationChange),
          child: Text(
            '${reputation.reputationChange > 0 ? '+' : ''}${reputation.reputationChange}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(reputation.reputationType),
        subtitle: Text(
          'Post ID: ${reputation.postId}\n'
          'Date: ${_formatDate(reputation.createdAt)}',
        ),
      ),
    );
  }

  Color _getReputationColor(int change) {
    if (change > 0) {
      return Colors.green;
    } else if (change < 0) {
      return Colors.red;
    }
    return Colors.grey;
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
