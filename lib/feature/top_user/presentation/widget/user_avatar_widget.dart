import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserImageAvatar extends StatelessWidget {
  final String avatarUrl;
  const UserImageAvatar({
    super.key,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: avatarUrl,
      child: CachedNetworkImage(
        imageUrl: avatarUrl,
      ),
    );
  }
}
