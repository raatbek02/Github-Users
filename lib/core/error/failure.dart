import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // List<Object?> get props => [];
  final String message;
  const Failure([this.message = 'An unexpected error occurred,']);
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}
