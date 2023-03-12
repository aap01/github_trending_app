import 'package:dartz/dartz.dart';
import 'package:github_favs/core/data/exception/app_exception.dart';
import 'package:github_favs/core/data/remote/remote_config.dart';
import 'package:github_favs/feature/common/data/datasource/remote/search_remote_datasource.dart';
import 'package:github_favs/feature/common/data/model/user_model_list.dart';

abstract class UserRemoteDatasource {
  Future<Either<AppException, UserModelList>> fetchList({
    required String countryName,
  });
}

class UserRemoteDatasourceImpl extends SearchRemoteDatasourceImpl<UserModelList>
    implements UserRemoteDatasource {
  static const _locationKey = 'location';
  static const _queryMap = {
    'followers': '>1000',
  };
  UserRemoteDatasourceImpl({
    required super.getApiClient,
    required super.modelConverter,
    required super.queryStringGenerator,
  });

  @override
  String getUrl() {
    return '${RemoteConfig.instance.baseUrl}/search/users';
  }

  @override
  Future<Either<AppException, UserModelList>> fetchList({
    required String countryName,
  }) {
    return super.search(
      queryMap: Map.from(_queryMap)
        ..putIfAbsent(
          _locationKey,
          () => countryName,
        ),
    );
  }
}
