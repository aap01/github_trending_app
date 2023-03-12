import 'package:dartz/dartz.dart';
import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:github_favs/feature/top_user/domain/entity/country_entity.dart';

abstract class CountryRepository {
  Future<Either<Failure, List<CountryEntity>>> getAll();
  Future<Either<Failure, CountryEntity>> getById({
    required int id,
  });
}
