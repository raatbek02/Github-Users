import 'package:dartz/dartz.dart';
import 'package:github_users/core/error/failure.dart';
import 'package:github_users/feature/users/domain/entities/user_detail_entity.dart';
import 'package:github_users/feature/users/domain/entities/users_entity.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<UsersEntity>>> getUsersList(int page);
  Future<Either<Failure, UserDetailEntity>> getDetailUser(String link);

}
