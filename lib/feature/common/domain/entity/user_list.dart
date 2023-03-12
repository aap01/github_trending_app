import 'package:equatable/equatable.dart';
import 'package:github_favs/feature/common/domain/entity/user_entity.dart';

class UserList extends Equatable {
  final int totalCount;
  final bool incompleteResult;
  final List<UserEntity> items;

  const UserList({
    required this.totalCount,
    required this.incompleteResult,
    required this.items,
  });

  @override
  List<Object?> get props => [
        totalCount,
        incompleteResult,
        items,
      ];
}
