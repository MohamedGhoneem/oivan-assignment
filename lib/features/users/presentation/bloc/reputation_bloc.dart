import 'package:app_fundamentals/app_fundamentals.dart';
import 'package:flutter/cupertino.dart';
import 'package:oivan_assignment/features/users/domain/entity/reputation_entity.dart';
import 'package:oivan_assignment/features/users/domain/use_case/get_reputation_use_case.dart';

import '../../../../core/common/pagination/pagination_handler.dart';
import '../../../../core/common/pagination/pagination_request_entity.dart';

class ReputationBloc {
  final GetReputationUseCase _getReputationUseCase;
  late final PaginationHandler paginationHandler;

  final BehaviorSubject<RequestState> requestStateSubject =
      BehaviorSubject.seeded(
    RequestState(
      status: RequestStatus.loading,
      message: RequestStatus.loading.name,
    ),
  );
  late int userId;
  final _reputationSubject = BehaviorSubject<List<ReputationEntity>>();

  Stream<List<ReputationEntity>> get reputationStream =>
      _reputationSubject.stream;
  final List<ReputationEntity> _allReputation = [];

  List<ReputationEntity> get allReputation => _allReputation;

  ReputationBloc(this._getReputationUseCase) {
    paginationHandler = PaginationHandler(
      requestStateSubject: requestStateSubject,
      voidCallback: _fetchUsers,
    );
  }

  void reset() {
    _allReputation.clear();
    paginationHandler.reset();
    fetchUsers();
  }

  void fetchUsers() {
    debugPrint('Fetching page: ${paginationHandler.page}');
    paginationHandler.callPaginatedRequest();
  }

  Future<void> _fetchUsers() async {
    _updateRequestState(_allReputation.isEmpty
        ? RequestStatus.loading
        : RequestStatus.loadMore);

    final params = GetReputationUseCaseParams(
        PaginationRequestEntity(
          page: paginationHandler.page,
          pageSize: paginationHandler.size,
        ),
        userId);

    final result = await _getReputationUseCase.execute(params);

    result.fold(
      (failure) {
        debugPrint('Failed to fetch users: $failure');
        _updateRequestState(RequestStatus.error);
      },
      (response) => _handleUserResponse(response),
    );
  }

  void _handleUserResponse(dynamic response) {
    final users = response.data;
    debugPrint('Fetched users: ${users?.length}');

    paginationHandler.hasMore = response.hasMore ?? true;

    if (users?.isEmpty ?? true) {
      _updateRequestState(RequestStatus.empty);
      return;
    }

    if (response.quotaRemaining != null && response.quotaRemaining! <= 0) {
      paginationHandler.hasMore = false;
    }

    _allReputation.addAll(users ?? []);
    _reputationSubject.add(_allReputation);
    _updateRequestState(RequestStatus.success);
  }

  void _updateRequestState(RequestStatus status) {
    requestStateSubject.sink.add(
      RequestState(
        status: status,
        message: status.name,
      ),
    );
  }

  void dispose() {
    requestStateSubject.close();
    _reputationSubject.close();
    paginationHandler.dispose();
  }
}
