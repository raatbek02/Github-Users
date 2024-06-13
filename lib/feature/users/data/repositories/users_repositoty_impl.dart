import 'package:dartz/dartz.dart';
import 'package:github_users/core/error/exception.dart';
import 'package:github_users/core/error/failure.dart';
import 'package:github_users/core/platform/network.info.dart';
import 'package:github_users/feature/users/data/datasourses/users_local_data_soure.dart';
import 'package:github_users/feature/users/data/datasourses/users_remote_data_source.dart';
import 'package:github_users/feature/users/data/models/users_model.dart';
import 'package:github_users/feature/users/domain/entities/user_detail_entity.dart';
import 'package:github_users/feature/users/domain/entities/users_entity.dart';
import 'package:github_users/feature/users/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UsersRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<UsersEntity>>> getUsersList(int page) async {
    return await _getPersons(() {
      return remoteDataSource.getUsersList(page);
    });
  }



  Future<Either<Failure, List<UsersModel>>> _getPersons(
      Future<List<UsersModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataSource.getLastPersonsFromCache();
        return Right(localPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, UserDetailEntity>> getDetailUser(String link)async {
    try {
        final remotePerson =  await remoteDataSource.getDetailUser(link);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
  }
}
