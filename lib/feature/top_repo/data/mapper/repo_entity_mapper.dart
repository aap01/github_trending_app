import 'package:github_favs/core/data/mapper/mapper.dart';
import 'package:github_favs/feature/top_repo/data/model/repo_model.dart';
import 'package:github_favs/feature/top_repo/domain/entity/repo_entity.dart';

class RepoEntityMapper extends MapperImpl<RepoModel, RepoEntity> {
  @override
  RepoEntity map(RepoModel from) {
    return super.runThroughMappingExceptionCatcher(() {
      return RepoEntity(
        id: from.id,
        createdAt: from.createdAt!,
        name: from.name!,
        private: from.private!,
        size: from.size!,
      );
    });
  }
}
