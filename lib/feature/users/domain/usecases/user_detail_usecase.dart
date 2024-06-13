

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:github_users/core/error/failure.dart';
import 'package:github_users/core/usecases/usecase.dart';
import 'package:github_users/feature/users/domain/entities/user_detail_entity.dart';
import 'package:github_users/feature/users/domain/repositories/users_repository.dart';

class UserDetailUseCase extends UseCase<UserDetailEntity, DetailUserParams> {
  final UsersRepository usersRepository;
  UserDetailUseCase(this.usersRepository);

  @override
  Future<Either<Failure, UserDetailEntity>> call(
      DetailUserParams params) async {
    return await usersRepository.getDetailUser(params.link);
  }
}

class DetailUserParams {
  final String link;

  DetailUserParams({
    required this.link,
   
  });
}


