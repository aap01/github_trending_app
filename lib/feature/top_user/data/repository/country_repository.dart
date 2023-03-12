import 'package:github_favs/core/data/local/local_datasource.dart';
import 'package:github_favs/core/data/mapper/mapper.dart';
import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:github_favs/feature/top_user/data/model/country_model.dart';
import 'package:github_favs/feature/top_user/domain/entity/country_entity.dart';
import 'package:github_favs/feature/top_user/domain/repository/country_repository.dart';

class CountryRepositoryImpl implements CountryRepository {
  final LocalDataSource<CountryModel> _localDataSource;
  final Mapper<CountryModel, CountryEntity> _countryEntityMaper;

  CountryRepositoryImpl({
    required LocalDataSource<CountryModel> localDataSource,
    required Mapper<CountryModel, CountryEntity> countryEntityMapper,
  })  : _localDataSource = localDataSource,
        _countryEntityMaper = countryEntityMapper;
  @override
  Future<Either<Failure, List<CountryEntity>>> getAll() async {
    return Right(
      _localDataSource
          .getAll()
          .map(
            (e) => _countryEntityMaper.map(e),
          )
          .toList(),
    );
  }

  @override
  Future<Either<Failure, CountryEntity>> getById({required int id}) async {
    final model = _localDataSource.getById(id: id);
    return Right(
      _countryEntityMaper.map(model),
    );
  }
}
