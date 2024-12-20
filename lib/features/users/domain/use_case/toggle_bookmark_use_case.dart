import 'package:dartz/dartz.dart';
import 'package:oivan_assignment/core/common/pagination/pagination_request_entity.dart';
import 'package:oivan_assignment/features/users/data/model/user_model.dart';
import 'package:oivan_assignment/features/users/data/repo/users_repo_impl.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/model/get_users_model.dart';
import '../entity/user_entity.dart';

class ToggleBookmarkUseCase
    implements UseCase<bool, ToggleBookmarkUseCaseParams> {
  final UsersRepoImpl repository;

  ToggleBookmarkUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> execute(
      ToggleBookmarkUseCaseParams params) async {
    return await repository.toggleBookmark(params);
  }
}

class ToggleBookmarkUseCaseParams {
  UserEntity userEntity;

  ToggleBookmarkUseCaseParams(this.userEntity);
}
