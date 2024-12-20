import 'package:dartz/dartz.dart';
import 'package:oivan_assignment/core/common/pagination/pagination_request_entity.dart';
import 'package:oivan_assignment/features/users/data/model/user_model.dart';
import 'package:oivan_assignment/features/users/data/repo/users_repo_impl.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/model/get_users_model.dart';
import '../entity/user_entity.dart';

class GetBookmarkedIdsUseCase
    implements UseCase<List<int>, GetBookmarkedIdsUseCaseParams> {
  final UsersRepoImpl repository;

  GetBookmarkedIdsUseCase(this.repository);

  @override
  Future<Either<Failure, List<int>>> execute(
      GetBookmarkedIdsUseCaseParams params) async {
    return await repository.getBookmarkedIds();
  }
}

class GetBookmarkedIdsUseCaseParams {
  GetBookmarkedIdsUseCaseParams();
}
