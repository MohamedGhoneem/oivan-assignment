import 'package:app_fundamentals/app_fundamentals.dart';
import 'package:flutter/cupertino.dart';
import 'package:oivan_assignment/features/users/data/model/user_model.dart';
import 'package:oivan_assignment/features/users/domain/use_case/get_bookmarked_ids_use_case.dart';
import 'package:oivan_assignment/features/users/domain/use_case/toggle_bookmark_use_case.dart';

import '../../../../core/common/pagination/pagination_handler.dart';
import '../../../../core/common/pagination/pagination_request_entity.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/use_case/get_users_use_case.dart';

class UsersBloc {
  final GetUsersUseCase _getUsersUseCase;
  final ToggleBookmarkUseCase _toggleBookmarkUseCase;
  final GetBookmarkedIdsUseCase _getBookmarkedIdsUseCase;
  late final PaginationHandler paginationHandler;

  final BehaviorSubject<RequestState> requestStateSubject =
      BehaviorSubject.seeded(
    RequestState(
      status: RequestStatus.loading,
      message: RequestStatus.loading.name,
    ),
  );

  final _usersSubject = BehaviorSubject<List<UserEntity>>();
  final _showBookmarkedOnlySubject = BehaviorSubject<bool>.seeded(false);

  Stream<List<UserEntity>> get usersStream => _usersSubject.stream;

  Stream<bool> get showBookmarkedOnlyStream =>
      _showBookmarkedOnlySubject.stream;

  final List<UserEntity> _allUsers = [];
  List<UserEntity> _filteredUsers = [];

  List<UserEntity> get filteredUsers => _filteredUsers;

  UsersBloc(this._getUsersUseCase, this._toggleBookmarkUseCase,
      this._getBookmarkedIdsUseCase) {
    paginationHandler = PaginationHandler(
      requestStateSubject: requestStateSubject,
      voidCallback: _fetchUsers,
    );
    _showBookmarkedOnlySubject.listen(_filterUsers);
  }

  void _filterUsers(bool showBookmarkedOnly) {
    _filteredUsers = showBookmarkedOnly
        ? _allUsers.where((user) => user.isBookmarked).toList()
        : List.from(_allUsers);
    _usersSubject.add(_filteredUsers);
  }

  void toggleBookmarkFilter() {
    _showBookmarkedOnlySubject.add(!_showBookmarkedOnlySubject.value);
  }

  Future<void> reset() async {
    _allUsers.clear();
    _filteredUsers.clear();
    paginationHandler.reset();
    await fetchUsers();
  }

  Future<void> fetchUsers() async {
    debugPrint('Fetching page: ${paginationHandler.page}');
    await paginationHandler.callPaginatedRequest();
  }

  Future<void> _fetchUsers() async {
    _updateRequestState(
        _allUsers.isEmpty ? RequestStatus.loading : RequestStatus.loadMore);

    final params = GetUsersUseCaseParams(
      PaginationRequestEntity(
        page: paginationHandler.page,
        pageSize: paginationHandler.size,
      ),
    );

    final result = await _getUsersUseCase.execute(params);

    result.fold(
      (failure) {
        debugPrint('Failed to fetch users: $failure');
        _updateRequestState(RequestStatus.error);
      },
      (response) => _handleUserResponse(response),
    );
  }

  void _handleUserResponse(dynamic response) {
    final users = response.users;
    debugPrint('Fetched users: ${users?.length}');

    paginationHandler.hasMore = response.hasMore ?? true;

    if (users?.isEmpty ?? true) {
      _updateRequestState(RequestStatus.empty);
      return;
    }

    if (response.quotaRemaining != null && response.quotaRemaining! <= 0) {
      paginationHandler.hasMore = false;
    }

    _allUsers.addAll(users ?? []);
    _filterUsers(_showBookmarkedOnlySubject.value);
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

  Future<void> toggleUserBookmark(UserEntity user) async {
    final params = ToggleBookmarkUseCaseParams(user);

    final result = await _toggleBookmarkUseCase.execute(params);
    _updateBookmarkedStatus();
  }

  void _updateBookmarkedStatus() async {
    for (var i = 0; i < _allUsers.length; i++) {
      final user = _allUsers[i];
      final result = await _getBookmarkedIdsUseCase
          .execute(GetBookmarkedIdsUseCaseParams());
      result.fold((failure) {
        debugPrint('Failed to fetch users: $failure');
      }, (response) {
        final isBookmarked = response.contains(user.userId);
        if (user.isBookmarked != isBookmarked) {
          _allUsers[i] = user.copyWith(isBookmarked: isBookmarked);
        }
      });
    }
    _filterUsers(_showBookmarkedOnlySubject.value);
  }

  void dispose() {
    requestStateSubject.close();
    _usersSubject.close();
    _showBookmarkedOnlySubject.close();
    paginationHandler.dispose();
  }
}
