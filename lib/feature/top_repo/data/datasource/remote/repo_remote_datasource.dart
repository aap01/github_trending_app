import 'package:dartz/dartz.dart';
import 'package:github_favs/core/data/exception/app_exception.dart';
import 'package:github_favs/core/data/remote/remote_config.dart';
import 'package:github_favs/feature/common/data/datasource/remote/search_remote_datasource.dart';
import 'package:github_favs/feature/top_repo/data/model/repo_model.dart';

abstract class RepoRemoteDatasoruce {
  Future<Either<AppException, List<RepoModel>>> fetchtList();
}

class RepoRemoteDatasoruceImpl extends SearchRemoteDatasourceImpl<RepoModel>
    implements RepoRemoteDatasoruce {
  static const _queryMap = {
    'stars': '>1000',
  };
  RepoRemoteDatasoruceImpl({
    required super.getApiClient,
    required super.userModelListConverter,
    required super.queryStringGenerator,
  });

  @override
  Future<Either<AppException, List<RepoModel>>> fetchtList() {
    return super.search(
      queryMap: _queryMap,
    );
  }

  @override
  String getUrl() {
    return '${RemoteConfig.instance.baseUrl}/search/repositories';
  }
}
