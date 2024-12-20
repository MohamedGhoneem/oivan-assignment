import 'package:app_fundamentals/app_fundamentals.dart';
import 'package:flutter/material.dart';
import 'package:oivan_assignment/features/users/presentation/view/reputation/widgets/reputation_list_item.dart';
import '../../../../../main.dart';
import '../../../domain/entity/reputation_entity.dart';
import '../../../domain/entity/user_entity.dart';
import '../../bloc/reputation_bloc.dart';

class ReputationPageMobile extends BaseStatefulWidget {
  final UserEntity user;

  const ReputationPageMobile({
    super.key,
    required this.user,
  });

  @override
  State<ReputationPageMobile> createState() => _ReputationScreenState();
}

class _ReputationScreenState extends BaseState<ReputationPageMobile> {
  late final ReputationBloc _reputationBloc;

  @override
  void initState() {
    super.initState();
    _reputationBloc = ReputationBloc(getIt());
    _reputationBloc.fetchUsers();
  }

  @override
  Widget setBody(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.user.profileImage),
                  radius: 30,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.displayName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (widget.user.location.isNotEmpty)
                        Text(
                          widget.user.location,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      Text(
                        'Reputation: ${widget.user.reputation}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<ReputationEntity>>(
            stream: _reputationBloc.reputationStream,
            builder: (context, snapshot) {
              return StreamingResult(
                subject: _reputationBloc.requestStateSubject,
                successWidget: ListView.builder(
                  controller: _reputationBloc.paginationHandler.controller,
                  itemCount: _reputationBloc.allReputation.length,
                  itemBuilder: (context, index) {
                    return ReputationListItem(
                        reputation: _reputationBloc.allReputation[index]);
                  },
                ),
                emptyWidget: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No Users Found'),
                      ElevatedButton(
                        onPressed: _reputationBloc.reset,
                        child: const Text('Refresh'),
                      ),
                    ],
                  ),
                ),
                retry: _reputationBloc.fetchUsers,
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget? setAppbar() {
    return AppBar(
      title: Text(widget.user.displayName),
    );
  }

  @override
  void dispose() {
    _reputationBloc.dispose();
    super.dispose();
  }
}
//
