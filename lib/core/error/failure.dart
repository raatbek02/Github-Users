import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // List<Object?> get props => [];
  final String message;
  Failure([this.message = 'An unexpected error occurred,']);
}

class ServerFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CacheFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
