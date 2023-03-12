import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_favs/feature/common/data/resource/srtin_resource.dart';
import 'package:github_favs/feature/common/domain/entity/user_entity.dart';
import 'package:github_favs/feature/top_user/presentation/widget/user_avatar_widget.dart';
import 'package:github_favs/feature/top_user/presentation/widget/user_short_info_widget.dart';

class UserWidget extends StatelessWidget {
  final UserEntity userEntity;
  final Function(int) onTap;
  const UserWidget({
    super.key,
    required this.userEntity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          GridTile(
            child: UserImageAvatar(avatarUrl: userEntity.avatarUrl),
          ),
          UserShortInfoWidget(
            login: userEntity.login,
            score: userEntity.score.toString(),
          ),
        ],
      ),
      onTap: () => onTap(userEntity.id),
    );
  }
}
