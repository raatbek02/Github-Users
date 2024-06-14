import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:github_users/core/error/failure.dart';
import 'package:github_users/core/usecases/usecase.dart';
import 'package:github_users/feature/users/domain/entities/users_entity.dart';
import 'package:github_users/feature/users/domain/repositories/users_repository.dart';

class UsersListUseCase extends UseCase<List<UsersEntity>, PageUsersParams> {
  final UsersRepository personRepository;
  UsersListUseCase(this.personRepository);

  @override
  Future<Either<Failure, List<UsersEntity>>> call(
      PageUsersParams params) async {
    return await personRepository.getUsersList(params.page);
  }
}

class PageUsersParams extends Equatable {
  final int page;
  const PageUsersParams({required this.page});

  @override
  List<Object> get props => [page];
}
