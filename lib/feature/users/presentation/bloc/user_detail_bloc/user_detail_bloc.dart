import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/feature/users/domain/usecases/user_detail_usecase.dart';
import 'package:github_users/feature/users/presentation/bloc/user_detail_bloc/user_detail_event.dart';
import 'package:github_users/feature/users/presentation/bloc/user_detail_bloc/user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserDetailUseCase _userDetailUseCase;
  UserDetailBloc({
    required UserDetailUseCase userDetailUseCase,
  })  : _userDetailUseCase = userDetailUseCase,
        super(UserDetailInitial()) {
    on<UserDetailEvent>((event, emit) => emit(UserDetailLoading()));
    on<UserDetailFetch>(_userDetailFetch);
  }

  void _userDetailFetch(
    UserDetailFetch event,
    Emitter<UserDetailState> emit,
  ) async {
    final res = await _userDetailUseCase(
      DetailUserParams(link: event.link),
    );

    res.fold(
      (l) => emit(UserDetailFailure(l.message)),
      (r) => emit(UserDetailDisplaySuccess(r)),
    );
  }
}
