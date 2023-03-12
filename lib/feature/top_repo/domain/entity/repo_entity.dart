import 'package:equatable/equatable.dart';

class RepoEntity extends Equatable {
  final int id;
  final String name;
  final bool private;
  final DateTime createdAt;
  final int size;

  const RepoEntity({
    required this.id,
    required this.name,
    required this.private,
    required this.createdAt,
    required this.size,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        private,
        createdAt,
        size,
      ];
}
