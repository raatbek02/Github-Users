import 'package:flutter/material.dart';

@immutable
abstract class UsersListEvent {}

class UsersListFetch extends UsersListEvent {}

class UsersListLoadMore extends UsersListEvent {}
