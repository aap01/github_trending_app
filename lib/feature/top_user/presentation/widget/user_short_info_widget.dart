import 'package:flutter/material.dart';
import 'package:github_favs/feature/common/data/resource/srtin_resource.dart';

class UserShortInfoWidget extends StatelessWidget {
  final String login;
  final String score;

  const UserShortInfoWidget({
    super.key,
    required this.login,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserNameWidget(login: login),
            const SizedBox(height: 5),
            UserScoreWidget(score: score),
          ],
        ),
      ),
    );
  }
}

class UserScoreWidget extends StatelessWidget {
  const UserScoreWidget({
    super.key,
    required this.score,
  });

  final String score;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${StringResource.score} $score',
    );
  }
}

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({
    super.key,
    required this.login,
  });

  final String login;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: login,
      child: Text(
        login,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
