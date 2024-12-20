import 'package:dartz/dartz.dart';
import 'package:oivan_assignment/features/users/domain/use_case/get_reputation_use_case.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/get_reputation_model.dart';
import '../../data/model/get_users_model.dart';
import '../../data/model/user_model.dart';
import '../use_case/get_users_use_case.dart';

abstract class UsersRepo {
  Future<Either<Failure, GetUsersModel>> getUsers(GetUsersUseCaseParams params);

  Future<Either<Failure, GetReputationModel>> getUserReputation(GetReputationUseCaseParams params);

  Future<Either<Failure, bool>> toggleBookmark(UserModel user);
  Future<Either<Failure, List<UserModel>>> getBookmarkedUsers();
}
