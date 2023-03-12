import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:github_favs/core/data/exception/app_exception.dart';
import 'package:github_favs/core/data/model/api_response_model.dart';
import 'package:http/http.dart' as http;

abstract class _Api {
  Future<Either<AppException, ApiResponseModel>> runThroughExceptionCatcher(
    Future<Either<AppException, ApiResponseModel>> Function() f,
  ) async {
    try {
      final apiResponseModel = await f();
      return apiResponseModel;
    } on SocketException {
      throw const AppException.noInternetException();
    } on Exception {
      throw const AppException.serverException();
    }
  }
}

abstract class GetApiClient {
  Future<Either<AppException, ApiResponseModel>> call({
    required String url,
    Map<String, String>? headers,
  });
}

class GetApiClientImpl extends _Api implements GetApiClient {
  final http.Client _client;

  GetApiClientImpl({
    required http.Client client,
  }) : _client = client;
  @override
  Future<Either<AppException, ApiResponseModel>> call({
    required String url,
    Map<String, String>? headers,
  }) {
    return super.runThroughExceptionCatcher(() async {
      final response = await _client.get(
        Uri.parse(url),
        headers: headers,
      );
      print(url);
      return Right(
        ApiResponseModel(
          url: url,
          headers: response.headers,
          body: response.body,
          statusCode: response.statusCode,
        ),
      );
    });
  }
}
