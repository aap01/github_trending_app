import 'package:github_favs/core/data/exception/app_exception.dart';
import 'package:github_favs/core/data/local/local_datasource.dart';
import 'package:github_favs/core/data/mapper/mapper.dart';
import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:github_favs/feature/common/data/datasource/remote/user_remote_datasource.dart';
import 'package:github_favs/feature/common/data/model/user_model.dart';
import 'package:github_favs/feature/common/domain/entity/user_entity.dart';
import 'package:github_favs/feature/common/domain/entity/user_list.dart';
import 'package:github_favs/feature/common/domain/repository/user_repository.dart';
import 'package:github_favs/feature/top_user/domain/entity/user_details.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource _userRemoteDatasource;
  final Mapper<AppException, Failure> _failureMapper;
  final LocalDataSource<UserModel> _userLoaclDatasource;
  final Mapper<UserModel, UserEntity> _userEntityMapper;
  final Mapper<UserModel, UserDetails> _userDetailsMapper;

  UserRepositoryImpl({
    required UserRemoteDatasource userRemoteDatasource,
    required Mapper<AppException, Failure> failureMapper,
    required Mapper<UserModel, UserDetails> userDetailsMapper,
    required Mapper<UserModel, UserEntity> userEntityMapper,
    required LocalDataSource<UserModel> userLocalDatasource,
  })  : _userRemoteDatasource = userRemoteDatasource,
        _userDetailsMapper = userDetailsMapper,
        _failureMapper = failureMapper,
        _userLoaclDatasource = userLocalDatasource,
        _userEntityMapper = userEntityMapper;
  @override
  Future<Either<Failure, UserList>> getPagedListByCountry({
    required int count,
    required int page,
    required String countryName,
  }) async {
    final userModelListEither = await _userRemoteDatasource.fetchList(
      countryName: countryName,
    );
    return userModelListEither.fold(
      (l) => Left(_failureMapper.map(l)),
      (r) {
        if (r.items == null || r.items!.isEmpty) {
          const Right(
            UserList(
              totalCount: 0,
              items: [],
              incompleteResult: false,
            ),
          );
        }

        final items = r.items!;
        _userLoaclDatasource.clear();
        _userLoaclDatasource.addAll(modelList: items);
        final servedCount = (page - 1) * count;
        if (servedCount < items.length) {
          final pagedList = items.skip(count).take(count);
          try {
            final entityList =
                pagedList.map((e) => _userEntityMapper.map(e)).toList();
            return Right(UserList(
              items: entityList,
              totalCount: items.length,
              incompleteResult: false,
            ));
          } on AppException catch (e) {
            return Left(_failureMapper.map(e));
          }
        }
        return Right(
          UserList(
            totalCount: items.length,
            items: const [],
            incompleteResult: false,
          ),
        );
      },
    );
  }

  @override
  Future<Either<Failure, UserDetails>> getUserDetailsById({
    required int id,
  }) async {
    try {
      return Right(
        _userDetailsMapper.map(
          _userLoaclDatasource.getById(id: id),
        ),
      );
    } on AppException catch (e) {
      return Left(_failureMapper.map(e));
    }
  }
}
