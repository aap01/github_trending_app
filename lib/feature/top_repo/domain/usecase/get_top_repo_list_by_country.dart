import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:github_favs/core/domain/usecase/usecase.dart';
import 'package:github_favs/feature/dashboard/domain/entity/repo_entity.dart';
import 'package:github_favs/feature/dashboard/domain/repository/country_repository.dart';
import 'package:github_favs/feature/dashboard/domain/repository/repo_repository.dart';

class GetRepoListInputParams with EntityParams, PaginatedInputParams {}

class GetTopUsersByCountry
    extends Usecase<GetRepoListInputParams, List<RepoEntity>> {
  final CountryRepository _countryRepository;
  final RepoRepository _repoRepository;

  GetTopUsersByCountry({
    required CountryRepository countryRepository,
    required RepoRepository repoRepository,
  })  : _repoRepository = repoRepository,
        _countryRepository = countryRepository;
  @override
  Future<Either<Failure, List<RepoEntity>>> call({
    required GetRepoListInputParams inParams,
  }) async {
    final country = await _countryRepository.getById(
      id: inParams.id,
    );
    return country.fold(
      (l) => Left(l),
      (r) => _repoRepository.getPagedListByCountry(
        count: inParams.count,
        page: inParams.page,
        countryName: r.name,
      ),
    );
  }
}
