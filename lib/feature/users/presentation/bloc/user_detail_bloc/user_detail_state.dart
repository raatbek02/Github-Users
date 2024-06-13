import 'package:flutter/material.dart';
import 'package:github_users/feature/users/domain/entities/user_detail_entity.dart';

@immutable
sealed class UserDetailState {}

final class UserDetailInitial extends UserDetailState {}

final class UserDetailLoading extends UserDetailState {}

final class UserDetailFailure extends UserDetailState {
  final String error;
  UserDetailFailure(this.error);
}


final class UserDetailDisplaySuccess extends UserDetailState {
  final UserDetailEntity userDetail;
  UserDetailDisplaySuccess(this.userDetail);
}
