import 'package:equatable/equatable.dart';
import 'package:oyt_front_core/external/api_response.dart';

class ApiException extends Equatable {
  const ApiException(this.response);
  final ApiResponse response;

  static const generalError = 'Ha ocurrido un error';

  String get error {
    final resMap = response.responseMap;
    if (resMap == null) return generalError;
    final error = resMap['msg'] ?? generalError;
    return error;
  }

  @override
  String toString() => error;

  @override
  List<Object?> get props => [response];
}
