import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:oivan_assignment/features/users/data/ds/users_local_ds.dart';
import 'package:oivan_assignment/features/users/domain/use_case/get_reputation_use_case.dart';
import 'package:oivan_assignment/features/users/domain/use_case/get_users_use_case.dart';
import 'package:oivan_assignment/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'features/users/data/ds/users_remote_ds.dart';
import 'features/users/data/repo/users_repo_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  return runApp(const App());
}

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => UsersRemoteDataSource(network));
  getIt.registerLazySingleton(() => UsersLocalDataSource(getIt()));

  getIt.registerLazySingleton(
    () => UsersRepoImpl(
      getIt(),
      getIt(),
    ),
  );

  getIt.registerLazySingleton(() => GetUsersUseCase(getIt()));
  getIt.registerLazySingleton(() => GetReputationUseCase(getIt()));
}
