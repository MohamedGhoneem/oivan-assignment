import 'package:dartz/dartz.dart';
import 'package:oivan_assignment/features/users/data/model/user_model.dart';
import 'package:oivan_assignment/features/users/domain/entity/user_entity.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repo/users_repo.dart';
import '../../domain/use_case/get_reputation_use_case.dart';
import '../../domain/use_case/get_users_use_case.dart';
import '../../domain/use_case/toggle_bookmark_use_case.dart';
import '../ds/users_local_ds.dart';
import '../ds/users_remote_ds.dart';
import '../model/get_reputation_model.dart';
import '../model/get_users_model.dart';
import '../model/request_model.dart';

class UsersRepoImpl implements UsersRepo {
  final UsersRemoteDataSource _remoteDataSource;
  final UsersLocalDataSource _localDataSource;

  UsersRepoImpl(this._remoteDataSource, this._localDataSource);

  // @override
  // Future<Either<Failure, GetUsersModel>> getUsers(
  //     GetUsersUseCaseParams params) async {
  //   try {
  //     final remoteUsers = await _remoteDataSource.getUsers(RequestModel(
  //       site: 'stackoverflow',
  //       paginationRequestEntity: params.paginationRequestEntity,
  //     ));
  //     final localBookmarks = await _localDataSource.getBookmarkedUserIds();
  //     final users = remoteUsers.users?.map((user) {
  //       user.isBookmarked = localBookmarks.contains(user.userId);
  //       return user;
  //     }).toList();
  //     return Right(GetUsersModel(users: users));
  //   } catch (e) {
  //     return Left(ServerFailure());
  //   }
  // }

  @override
  Future<Either<Failure, GetUsersModel>> getUsers(
      GetUsersUseCaseParams params) async {
    try {
      print('Starting getUsers repository method');

      final requestModel = RequestModel(
        paginationRequestEntity: params.paginationRequestEntity,
        site: 'stackoverflow',
      );

      final response = await _remoteDataSource.getUsers(requestModel);
      print('Got remote response: $response');

      final bookmarkedIds = await _localDataSource.getBookmarkedUserIds();
      print('Got bookmarked IDs: $bookmarkedIds');

      if (response.users == null) {
        print('Response users is null');
        return Right(response);
      }

      final updatedUsers = response.users!.map((user) {
        final isBookmarked = bookmarkedIds.contains(user.userId);
        print('User ${user.userId} bookmarked status: $isBookmarked');

        return UserModel(
          userId: user.userId,
          displayName: user.displayName,
          profileImage: user.profileImage,
          reputation: user.reputation,
          location: user.location,
          age: user.age,
          isBookmarked: isBookmarked,
        );
      }).toList();

      final updatedResponse = GetUsersModel(
        users: updatedUsers,
        hasMore: response.hasMore,
        quotaMax: response.quotaMax,
        quotaRemaining: response.quotaRemaining,
      );

      print('Returning updated response: $updatedResponse');
      return Right(updatedResponse);
    } catch (e, stackTrace) {
      print('Error in getUsers: $e');
      print('StackTrace: $stackTrace');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetReputationModel>> getUserReputation(
      GetReputationUseCaseParams params) async {
    try {
      final history = await _remoteDataSource.getUserReputation(
          RequestModel(
            site: 'stackoverflow',
            paginationRequestEntity: params.paginationRequestEntity,
          ),
          params.userId);
      return Right(history);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> toggleBookmark(
      ToggleBookmarkUseCaseParams params) async {
    try {
      params.userEntity.isBookmarked = !params.userEntity.isBookmarked;
      await _localDataSource.toggleBookmark(params.userEntity);
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getBookmarkedUsers() async {
    try {
      final users = await _localDataSource.getBookmarkedUsers();
      return Right(users);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<int>>> getBookmarkedIds() async {
    try {
      final users = await _localDataSource.getBookmarkedUserIds();
      return Right(users);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
