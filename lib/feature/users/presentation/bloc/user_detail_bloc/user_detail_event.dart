

import 'package:flutter/material.dart';

@immutable
sealed class UserDetailEvent {}

final class UserDetailFetch extends UserDetailEvent {
  final String link;

  UserDetailFetch({
    required this.link,
  });
}

