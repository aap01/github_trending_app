import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String avatarUrl;
  final double score;
  final String login;

  const UserEntity({
    required this.id,
    required this.avatarUrl,
    required this.score,
    required this.login,
  });

  @override
  List<Object?> get props => [
        id,
        avatarUrl,
        score,
        login,
      ];
}
