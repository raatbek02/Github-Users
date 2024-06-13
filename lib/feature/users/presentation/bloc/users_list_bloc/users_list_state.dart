import 'package:flutter/material.dart';
import 'package:github_users/feature/users/domain/entities/users_entity.dart';


@immutable
abstract class UsersListState {}

class UsersListInitial extends UsersListState {}

class UsersListLoading extends UsersListState {
  final List<UsersEntity> oldPersonList;
  final bool isFirstFetch;

  UsersListLoading(this.oldPersonList, {this.isFirstFetch = false});
}

class UsersListLoaded extends UsersListState {
  final List<UsersEntity> personList;

  UsersListLoaded(this.personList);
}

class UsersListError extends UsersListState {
  final String message;

  UsersListError(this.message);
}

