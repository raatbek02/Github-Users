import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/feature/users/domain/entities/users_entity.dart';
import 'package:github_users/feature/users/presentation/bloc/users_list_bloc/users_list_bloc.dart';
import 'package:github_users/feature/users/presentation/bloc/users_list_bloc/users_list_event.dart';
import 'package:github_users/feature/users/presentation/bloc/users_list_bloc/users_list_state.dart';
import 'package:github_users/feature/users/presentation/widgets/user_card_widget.dart';

class UsersList extends StatelessWidget {
  final scrollController = ScrollController();

  UsersList({super.key});

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<UsersListBloc>().add(UsersListLoadMore());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    return BlocBuilder<UsersListBloc, UsersListState>(
      builder: (context, state) {
        List<UsersEntity> users = [];
        bool isLoading = false;

        if (state is UsersListInitial) {
          return _loadingIndicator();
        } else if (state is UsersListLoading) {
          users = state.oldPersonList;
          isLoading = true;
        } else if (state is UsersListLoaded) {
          users = state.personList;
        } else if (state is UsersListError) {
          return Text(
            state.message,
            style: const TextStyle(color: Colors.white, fontSize: 25),
          );
        }

        return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < users.length) {
              return PersonCard(user: users[index]);
            } else {
              Timer(const Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[400],
            );
          },
          itemCount: users.length + (isLoading ? 1 : 0),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
