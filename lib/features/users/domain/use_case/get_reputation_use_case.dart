
import 'package:dartz/dartz.dart';
import 'package:oivan_assignment/core/common/pagination/pagination_request_entity.dart';
import 'package:oivan_assignment/features/users/data/model/get_reputation_model.dart';
import 'package:oivan_assignment/features/users/data/repo/users_repo_impl.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetReputationUseCase
    implements UseCase<GetReputationModel, GetReputationUseCaseParams> {
  final UsersRepoImpl repository;

  GetReputationUseCase(this.repository);

  @override
  Future<Either<Failure, GetReputationModel>> execute(GetReputationUseCaseParams params) async {
    return await repository.getUserReputation(params);
  }
}

class GetReputationUseCaseParams {
   int userId;
  PaginationRequestEntity paginationRequestEntity;

  GetReputationUseCaseParams(this.paginationRequestEntity, this.userId);
}
