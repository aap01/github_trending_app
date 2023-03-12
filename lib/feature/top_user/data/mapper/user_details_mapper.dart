import 'package:github_favs/core/data/mapper/mapper.dart';
import 'package:github_favs/feature/common/data/model/user_model.dart';
import 'package:github_favs/feature/top_user/domain/entity/user_details.dart';

class UserDetailsMapper extends MapperImpl<UserModel, UserDetails> {
  @override
  UserDetails map(UserModel from) {
    return super.runThroughMappingExceptionCatcher(
      () {
        return UserDetails(
          id: from.id,
          avatarUrl: from.avatarurl!,
          score: from.score!,
          login: from.login!,
        );
      },
    );
  }
}
