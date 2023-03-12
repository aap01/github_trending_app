import 'package:get_it/get_it.dart';
import 'package:github_favs/core/data/exception/app_exception.dart';
import 'package:github_favs/core/data/mapper/mapper.dart';
import 'package:github_favs/core/data/network/api_client.dart';
import 'package:github_favs/core/data/remote/query_string_genrator.dart';
import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:http/http.dart';

class AppDependency {
  final GetIt _sl;

  AppDependency({
    required GetIt sl,
  }) : _sl = sl;
  Future<void> init() async {
    _sl.registerFactory<GetApiClient>(
      () => GetApiClientImpl(
        client: _sl(),
      ),
    );
    _sl.registerLazySingleton<Client>(
      () => Client(),
    );
    _sl.registerFactory<Mapper<AppException, Failure>>(
      () => ExceptionToFailureMapperImpl(),
    );
    _sl.registerFactory<QueryStringGenerator>(
      () => GithubQueryStringGenerator(),
    );
  }
}
