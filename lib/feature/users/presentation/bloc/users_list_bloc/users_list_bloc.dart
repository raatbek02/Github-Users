import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/feature/users/domain/entities/users_entity.dart';
import 'package:github_users/feature/users/domain/usecases/users_list_usecase.dart';
import 'package:github_users/feature/users/presentation/bloc/users_list_bloc/users_list_event.dart';
import 'package:github_users/feature/users/presentation/bloc/users_list_bloc/users_list_state.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  final UsersListUseCase usersListUseCase;
  int page = 1;

  UsersListBloc({required this.usersListUseCase}) : super(UsersListInitial()) {
    on<UsersListFetch>(_onPersonListFetch);
    on<UsersListLoadMore>(_onPersonListLoadMore);
  }

  Future<void> _onPersonListFetch(
    UsersListFetch event,
    Emitter<UsersListState> emit,
  ) async {
    if (state is UsersListLoading) return;

    final oldUsersList = state is UsersListLoaded
        ? (state as UsersListLoaded).personList
        : <UsersEntity>[];

    emit(UsersListLoading(oldUsersList, isFirstFetch: true));

    final failureOrPerson = await usersListUseCase(const PageUsersParams(page: 1));

    failureOrPerson.fold(
      (error) => emit(UsersListError("")),
      (personList) => emit(UsersListLoaded(personList)),
    );
  }

  Future<void> _onPersonListLoadMore(
    UsersListLoadMore event,
    Emitter<UsersListState> emit,
  ) async {
    if (state is UsersListLoading) return;

    final currentState = state;

    var oldPersonList = <UsersEntity>[];
    if (currentState is UsersListLoaded) {
      oldPersonList = currentState.personList;
    }

    emit(UsersListLoading(oldPersonList, isFirstFetch: false));

    final failureOrPerson = await usersListUseCase(PageUsersParams(page: page));

    failureOrPerson.fold(
      (error) => emit(UsersListError("Error")),
      (personList) {
        page++;
        oldPersonList.addAll(personList);
        emit(UsersListLoaded(oldPersonList));
      },
    );
  }
}
