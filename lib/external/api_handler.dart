import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:oyt_front_core/constants/api_constants.dart';
import 'package:oyt_front_core/constants/db_constants.dart';
import 'package:oyt_front_core/external/api_exception.dart';
import 'package:oyt_front_core/external/api_response.dart';
import 'package:oyt_front_core/external/db_handler.dart';
import 'package:oyt_front_core/logger/logger.dart';

final apiHandlerProvider = Provider<ApiHandler>((ref) => ApiHandlerImpl(ref: ref));

abstract class ApiHandler {
  Future<ApiResponse> get(String path);
  Future<ApiResponse> delete(String path, Map<String, dynamic> body);
  Future<ApiResponse> patch(String path, Map<String, dynamic> body);
  Future<ApiResponse> post(String path, Map<String, dynamic> body);
  Future<ApiResponse> put(String path, Map<String, dynamic> body);
  Future<Map<String, String>> getHeaders();
  Uri getUri(String path);
  void logOnError(String path, Map<String, dynamic>? body, String exception, StackTrace stackTrace);
  void logOnApiException(ApiException apiException);
  void logOnStart(String path, Map<String, dynamic>? body, String method, Map headers);
  void logOnSuccess(ApiResponse response);
  List<int> processBody(Map<String, dynamic> body);
}

class ApiHandlerImpl implements ApiHandler {
  const ApiHandlerImpl({required this.ref});

  final Ref ref;

  @override
  Future<ApiResponse> delete(String path, Map<String, dynamic> body) async {
    try {
      final headers = await getHeaders();
      logOnStart(path, null, 'DELETE', headers);
      final res = await http.delete(getUri(path), headers: headers, body: processBody(body));
      final apiResponse = ApiResponse(
        path: path,
        body: null,
        response: res.body,
        statusCode: res.statusCode,
        headers: headers,
      );
      if (apiResponse.isError) throw ApiException(apiResponse);
      logOnSuccess(apiResponse);
      return apiResponse;
    } on ApiException catch (e) {
      logOnApiException(e);
      rethrow;
    } catch (e, s) {
      logOnError(path, null, e.toString(), s);
      rethrow;
    }
  }

  @override
  Future<ApiResponse> get(String path) async {
    try {
      final headers = await getHeaders();
      logOnStart(path, null, 'GET', headers);
      final res = await http.get(getUri(path), headers: headers);
      final apiResponse = ApiResponse(
        path: path,
        body: null,
        response: res.body,
        statusCode: res.statusCode,
        headers: headers,
      );
      if (apiResponse.isError) throw ApiException(apiResponse);
      logOnSuccess(apiResponse);
      return apiResponse;
    } on ApiException catch (e) {
      logOnApiException(e);
      rethrow;
    } catch (e, s) {
      logOnError(path, null, e.toString(), s);
      rethrow;
    }
  }

  @override
  Future<ApiResponse> patch(String path, Map<String, dynamic> body) async {
    try {
      final headers = await getHeaders();
      logOnStart(path, null, 'PATCH', headers);
      final res = await http.patch(getUri(path), headers: headers, body: processBody(body));
      final apiResponse = ApiResponse(
        path: path,
        body: body,
        response: res.body,
        statusCode: res.statusCode,
        headers: headers,
      );
      if (apiResponse.isError) throw ApiException(apiResponse);
      logOnSuccess(apiResponse);
      return apiResponse;
    } on ApiException catch (e) {
      logOnApiException(e);
      rethrow;
    } catch (e, s) {
      logOnError(path, null, e.toString(), s);
      rethrow;
    }
  }

  @override
  Future<ApiResponse> post(String path, Map<String, dynamic> body) async {
    try {
      final headers = await getHeaders();
      logOnStart(path, null, 'POST', headers);
      final res = await http.post(getUri(path), headers: headers, body: processBody(body));
      final apiResponse = ApiResponse(
        path: path,
        body: body,
        response: res.body,
        statusCode: res.statusCode,
        headers: headers,
      );
      if (apiResponse.isError) throw ApiException(apiResponse);
      logOnSuccess(apiResponse);
      return apiResponse;
    } on ApiException catch (e) {
      logOnApiException(e);
      rethrow;
    } catch (e, s) {
      logOnError(path, null, e.toString(), s);
      rethrow;
    }
  }

  @override
  Future<ApiResponse> put(String path, Map<String, dynamic> body) async {
    try {
      final headers = await getHeaders();
      logOnStart(path, null, 'PUT', headers);
      final res = await http.put(getUri(path), headers: headers, body: processBody(body));
      final apiResponse = ApiResponse(
        path: path,
        body: body,
        response: res.body,
        statusCode: res.statusCode,
        headers: headers,
      );
      if (apiResponse.isError) throw ApiException(apiResponse);
      logOnSuccess(apiResponse);
      return apiResponse;
    } on ApiException catch (e) {
      logOnApiException(e);
      rethrow;
    } catch (e, s) {
      logOnError(path, null, e.toString(), s);
      rethrow;
    }
  }

  @override
  Uri getUri(String path) => Uri.parse('${ApiConstants.baseUrl}$path');

  @override
  void logOnApiException(ApiException apiException) {
    Logger.log('######## API EXCEPTION ########');
    Logger.log('ApiResponse: ${apiException.response.toString()}');
    Logger.log('Error: ${apiException.toString()}');
    Logger.log('######## END API FAILURE ########');
  }

  @override
  void logOnError(
    String path,
    Map<String, dynamic>? body,
    String exception,
    StackTrace stackTrace,
  ) {
    Logger.log('######## API FAILURE ########');
    Logger.log('Path: $path');
    Logger.log('Body: $body');
    Logger.logError(exception, stackTrace);
    Logger.log('######## END API FAILURE ########');
  }

  @override
  void logOnStart(String path, Map<String, dynamic>? body, String method, Map headers) {
    Logger.log('######## API START ########');
    Logger.log('Path: $path');
    Logger.log('Body: $body');
    Logger.log('METHOD: $method');
    Logger.log('HEADERS: $headers');
    Logger.log('######## END API START ########');
  }

  @override
  void logOnSuccess(ApiResponse response) {
    Logger.log('######## API SUCCESS ########');
    Logger.log('Path: \n${response.path}');
    Logger.log('Body: \n${response.body}');
    Logger.log('StatusCode: \n${response.statusCode}');
    Logger.log('Headers: \n${response.headersFormatted}');
    Logger.log('Response: \n${response.responseFormatted}');
    Logger.log('######## END API SUCCESS ########');
  }

  @override
  Future<Map<String, String>> getHeaders() async {
    final dbProv = ref.read(dbHandlerProvider);
    final threadsResponse = await Future.wait([
      dbProv.get(DbConstants.bearerTokenKey, DbConstants.authBox),
      dbProv.get(DbConstants.restaurantsKey, DbConstants.restaurantBox)
    ]);
    final token = threadsResponse[0];
    final restaurantId = threadsResponse[1];
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'auth-token': token,
      if (restaurantId != null) 'restaurantId': restaurantId,
    };
  }

  @override
  List<int> processBody(Map<String, dynamic> body) => utf8.encode(json.encode(body));
}
