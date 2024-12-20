import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:app_fundamentals/app_fundamentals.dart';
import 'package:oivan_assignment/core/common/pagination/pagination_request_entity.dart';
import 'package:oivan_assignment/core/error/failures.dart';
import 'package:oivan_assignment/features/users/data/ds/users_local_ds.dart';
import 'package:oivan_assignment/features/users/data/ds/users_remote_ds.dart';
import 'package:oivan_assignment/features/users/data/model/get_users_model.dart';
import 'package:oivan_assignment/features/users/data/model/request_model.dart';
import 'package:oivan_assignment/features/users/data/model/user_model.dart';
import 'package:oivan_assignment/features/users/data/repo/users_repo_impl.dart';
import 'package:oivan_assignment/features/users/domain/use_case/get_users_use_case.dart';

import 'users_repo_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UsersRemoteDataSource>(),
  MockSpec<UsersLocalDataSource>(),
])void main() {
  late UsersRepoImpl repository;
  late MockUsersRemoteDataSource mockRemoteDataSource;
  late MockUsersLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockUsersRemoteDataSource();
    mockLocalDataSource = MockUsersLocalDataSource();
    repository = UsersRepoImpl(mockRemoteDataSource, mockLocalDataSource);
    when(mockLocalDataSource.getBookmarkedUserIds())
        .thenAnswer((_) async => [1]);
  });

  final testUsers = [
    UserModel(
      userId: 1,
      displayName: 'Test User',
      profileImage: 'http://example.com/image.jpg',
      reputation: 100,
      location: 'Test City',
      isBookmarked: false,
      age: 25,
    )
  ];

  final paginationRequest = PaginationRequestEntity(page: 1, pageSize: 20);

  group('getUsers', () {
    test('should return failure when remote data source fails', () async {
      // Arrange
      when(mockRemoteDataSource.getUsers(
              RequestModel(paginationRequestEntity: paginationRequest)))
          .thenThrow(Exception('Server error'));

      // Act
      final result =
          await repository.getUsers(GetUsersUseCaseParams(paginationRequest));

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Should not return success'),
      );
    });

    test('should return success with users and bookmark status', () async {
      // Arrange
      final response = GetUsersModel(
        users: testUsers,
        hasMore: true,
        quotaMax: 300,
        quotaRemaining: 299,
      );

      when(mockRemoteDataSource.getUsers(argThat(isA<RequestModel>())))
          .thenAnswer((_) async => response);
      when(mockLocalDataSource.getBookmarkedUserIds())
          .thenAnswer((_) async => [1]);

      // Act
      final result =
      await repository.getUsers(GetUsersUseCaseParams(paginationRequest));
      // Debug prints
      // Debug prints
      print('Response users: ${response.users}');
      print('Response users bookmarked: ${response.users?.first.isBookmarked}');
      print('Result fold:');
      result.fold(
            (failure) => print('Failure: $failure'),
            (success) {
          print('Success users: ${success.users}');
          print('Success users bookmarked: ${success.users?.first.isBookmarked}');
        },
      );
      // Assert
      expect(result, isA<Right<Failure, GetUsersModel>>());
      // Assert
      result.fold(
            (failure) => fail('Should not return failure'),
            (success) {
          expect(success.users, isNotNull);  // First check if users is not null
          expect(success.users!.isNotEmpty, true);  // Then check if it's not empty
          expect(success.users!.first, isNotNull);  // Check if first user exists
          expect(success.users!.first.isBookmarked, true,  // Finally check the bookmark status
              reason: 'First user should be bookmarked');
          expect(success.hasMore, true);
          expect(success.quotaMax, 300);
          expect(success.quotaRemaining, 299);
        },
      );

      verify(mockRemoteDataSource.getUsers(argThat(isA<RequestModel>()))).called(1);
      verify(mockLocalDataSource.getBookmarkedUserIds()).called(1);
    });

  });
}
