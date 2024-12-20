
import 'package:dartz/dartz.dart';
import 'package:oivan_assignment/core/common/pagination/pagination_request_entity.dart';
import 'package:oivan_assignment/features/users/data/repo/users_repo_impl.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/model/get_users_model.dart';

class GetUsersUseCase
    implements UseCase<GetUsersModel, GetUsersUseCaseParams> {
  final UsersRepoImpl repository;

  GetUsersUseCase(this.repository);

  @override
  Future<Either<Failure, GetUsersModel>> execute(GetUsersUseCaseParams params) async {
    return await repository.getUsers(params);
  }
}

class GetUsersUseCaseParams {
  PaginationRequestEntity paginationRequestEntity;

  GetUsersUseCaseParams(this.paginationRequestEntity);
}
