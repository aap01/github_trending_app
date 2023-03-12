import 'package:github_favs/core/data/exception/app_exception.dart';
import 'package:github_favs/core/data/local/local_datasource.dart';
import 'package:github_favs/core/data/mapper/mapper.dart';
import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:github_favs/feature/top_repo/data/datasource/remote/repo_remote_datasource.dart';
import 'package:github_favs/feature/top_repo/data/model/repo_model.dart';
import 'package:github_favs/feature/top_repo/domain/entity/repo_details.dart';
import 'package:github_favs/feature/top_repo/domain/entity/repo_entity.dart';
import 'package:github_favs/feature/top_repo/domain/repository/repo_repository.dart';

class RepoRepositoryImpl implements RepoRepository {
  final RepoRemoteDatasoruce _repoRemoteDatasource;
  final Mapper<AppException, Failure> _failureMapper;
  final LocalDataSource<RepoModel> _repoLoaclDatasource;
  final Mapper<RepoModel, RepoEntity> _repoEntityMapper;
  final Mapper<RepoModel, RepoDetails> _repoDetailsMapper;

  RepoRepositoryImpl({
    required RepoRemoteDatasoruce repoRemoteDatasource,
    required Mapper<AppException, Failure> failureMapper,
    required LocalDataSource<RepoModel> repoLoaclDatasource,
    required Mapper<RepoModel, RepoEntity> repoEntityMapper,
    required Mapper<RepoModel, RepoDetails> repoDetailsMapper,
  })  : _repoRemoteDatasource = repoRemoteDatasource,
        _failureMapper = failureMapper,
        _repoLoaclDatasource = repoLoaclDatasource,
        _repoEntityMapper = repoEntityMapper,
        _repoDetailsMapper = repoDetailsMapper;

  @override
  Future<Either<Failure, RepoDetails>> getById({
    required int id,
  }) async {
    return Right(
      _repoDetailsMapper.map(
        _repoLoaclDatasource.getById(id: id),
      ),
    );
  }

  @override
  Future<Either<Failure, List<RepoEntity>>> getPagedListByCountry({
    required int count,
    required int page,
    required String countryName,
  }) async {
    final repoModelList = _repoLoaclDatasource.getAll();
    if (repoModelList.isEmpty) {
      final repoModelListEither = await _repoRemoteDatasource.fetchtList();
      return repoModelListEither.fold(
        (l) => Left(_failureMapper.map(l)),
        (r) {
          if (r.isEmpty) {
            return const Right([]);
          }
          _repoLoaclDatasource.addAll(modelList: r);
          return getPagedListByCountry(
            count: count,
            page: page,
            countryName: countryName,
          );
        },
      );
    }
    final servedCount = (page - 1) * count;
    if (servedCount < repoModelList.length) {
      final pagedList = repoModelList.skip(count).take(count);
      try {
        final entityList =
            pagedList.map((e) => _repoEntityMapper.map(e)).toList();
        return Right(entityList);
      } on AppException catch (e) {
        return Left(_failureMapper.map(e));
      }
    }
    return const Right([]);
  }
}
