import 'package:github_favs/core/data/mapper/mapper.dart';
import 'package:github_favs/feature/common/data/model/user_model.dart';
import 'package:github_favs/feature/common/domain/entity/user_entity.dart';

class UserEntityMapper extends MapperImpl<UserModel, UserEntity> {
  @override
  UserEntity map(UserModel from) {
    return super.runThroughMappingExceptionCatcher(() {
      return UserEntity(
        id: from.id,
        avatarUrl: from.avatarurl!,
        login: from.login!,
        score: from.score!,
      );
    });
  }
}
