import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message];
}
