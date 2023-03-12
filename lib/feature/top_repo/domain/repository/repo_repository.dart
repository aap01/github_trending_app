import 'package:dartz/dartz.dart';
import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:github_favs/feature/dashboard/domain/entity/repo_details.dart';
import 'package:github_favs/feature/dashboard/domain/entity/repo_entity.dart';

abstract class RepoRepository {
  Future<Either<Failure, List<RepoEntity>>> getPagedListByCountry({
    required int count,
    required int page,
    required String countryName,
  });
  Future<Either<Failure, RepoDetails>> getById({
    required int id,
  });
}
