import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:github_favs/core/domain/usecase/usecase.dart';
import 'package:github_favs/feature/top_user/domain/entity/country_entity.dart';
import 'package:github_favs/feature/top_user/domain/repository/country_repository.dart';

class GetCountryList extends Usecase<NoParams, List<CountryEntity>> {
  final CountryRepository _countryRepository;

  GetCountryList({
    required CountryRepository countryRepository,
  }) : _countryRepository = countryRepository;
  @override
  Future<Either<Failure, List<CountryEntity>>> call({
    required NoParams inParams,
  }) =>
      _countryRepository.getAll();
}
