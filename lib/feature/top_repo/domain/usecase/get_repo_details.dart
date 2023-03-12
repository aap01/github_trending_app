import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:github_favs/core/domain/usecase/usecase.dart';
import 'package:github_favs/feature/dashboard/domain/entity/repo_details.dart';
import 'package:github_favs/feature/dashboard/domain/repository/repo_repository.dart';

class GetRepoDetailsInputParams with EntityParams {}

class GetRepoDetails extends Usecase<GetRepoDetailsInputParams, RepoDetails> {
  final RepoRepository _repoRepository;

  GetRepoDetails({
    required RepoRepository repoRepository,
  }) : _repoRepository = repoRepository;
  @override
  Future<Either<Failure, RepoDetails>> call({
    required GetRepoDetailsInputParams inParams,
  }) {
    return _repoRepository.getById(
      id: inParams.id,
    );
  }
}
