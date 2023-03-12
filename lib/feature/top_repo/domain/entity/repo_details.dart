import 'package:github_favs/feature/top_repo/domain/entity/repo_entity.dart';

class RepoDetails extends RepoEntity {
  const RepoDetails({
    required super.id,
    required super.name,
    required super.private,
    required super.createdAt,
    required super.size,
  });
}
