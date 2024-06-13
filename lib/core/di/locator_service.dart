import 'package:get_it/get_it.dart';
import 'package:github_users/core/platform/network.info.dart';
import 'package:github_users/feature/users/data/datasourses/users_local_data_soure.dart';
import 'package:github_users/feature/users/data/datasourses/users_remote_data_source.dart';
import 'package:github_users/feature/users/data/repositories/users_repositoty_impl.dart';
import 'package:github_users/feature/users/domain/repositories/users_repository.dart';
import 'package:github_users/feature/users/domain/usecases/users_list_usecase.dart';
import 'package:github_users/feature/users/domain/usecases/user_detail_usecase.dart';
import 'package:github_users/feature/users/presentation/bloc/user_detail_bloc/user_detail_bloc.dart';
import 'package:github_users/feature/users/presentation/bloc/users_list_bloc/users_list_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => UsersListBloc(usersListUseCase: sl<UsersListUseCase>()),
  );

  sl.registerFactory(
    () => UserDetailBloc(userDetailUseCase: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => UsersListUseCase(sl()));
  sl.registerLazySingleton(() => UserDetailUseCase(sl()));

  // Repository
  sl.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<UsersRemoteDataSource>(
    () => UsersRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<PersonLocalDataSource>(
    () => PersonLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
