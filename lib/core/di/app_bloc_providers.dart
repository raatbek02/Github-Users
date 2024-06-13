

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/core/common/bloc/language_bloc/language_bloc.dart';
import 'package:github_users/feature/users/presentation/bloc/user_detail_bloc/user_detail_bloc.dart';
import 'package:github_users/feature/users/presentation/bloc/users_list_bloc/users_list_bloc.dart';
import 'package:github_users/feature/users/presentation/bloc/users_list_bloc/users_list_event.dart';
import 'package:github_users/core/di/locator_service.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>(
          create: (context) => LanguageBloc(),
        ),
        BlocProvider<UsersListBloc>(
          create: (context) => sl<UsersListBloc>()..add(UsersListFetch()),
        ),
      
        BlocProvider<UserDetailBloc>(
          create: (context) => sl<UserDetailBloc>(),
        ),
      ],
      child: child,
    );
  }
}
