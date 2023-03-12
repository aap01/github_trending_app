import 'package:dartz/dartz.dart';
import 'package:github_favs/core/data/converter/converter.dart';
import 'package:github_favs/core/data/exception/app_exception.dart';
import 'package:github_favs/core/data/model/api_response_model.dart';
import 'package:github_favs/core/data/network/api_client.dart';
import 'package:github_favs/core/data/remote/query_string_genrator.dart';

abstract class SearchRemoteDatasource<TModel> {
  Future<Either<AppException, TModel>> search({
    Map<String, String>? queryMap,
  });
  String getUrl();
}

abstract class SearchRemoteDatasourceImpl<TModel>
    extends SearchRemoteDatasource<TModel> {
  final GetApiClient _getApiClient;
  final Converter<ApiResponseModel, TModel> _modelConverter;
  final QueryStringGenerator _queryStringGenerator;

  SearchRemoteDatasourceImpl({
    required GetApiClient getApiClient,
    required Converter<ApiResponseModel, TModel> modelConverter,
    required QueryStringGenerator queryStringGenerator,
  })  : _modelConverter = modelConverter,
        _getApiClient = getApiClient,
        _queryStringGenerator = queryStringGenerator;

  @override
  Future<Either<AppException, TModel>> search({
    Map<String, String>? queryMap,
  }) async {
    final url = getUrl() +
        _queryStringGenerator.generate(
          map: queryMap,
        );
    final apiResponseModelEither = await _getApiClient(
      url: url,
    );
    return apiResponseModelEither.fold(
      (l) => Left(l),
      (r) {
        print(r.body);
        return Right(
          _modelConverter.convert(r),
        );
      },
    );
  }
}
