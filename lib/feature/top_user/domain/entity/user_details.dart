import 'package:github_favs/feature/common/domain/entity/user_entity.dart';

class UserDetails extends UserEntity {
  const UserDetails({
    required super.id,
    required super.avatarUrl,
    required super.score,
    required super.login,
  });
}
