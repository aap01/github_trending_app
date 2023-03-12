import 'package:equatable/equatable.dart';
import 'package:github_favs/feature/common/domain/entity/user_entity.dart';
import 'package:github_favs/feature/top_user/domain/entity/country_entity.dart';

class TopUserState extends Equatable {
  final int totalCount;
  final bool loading;
  final List<UserEntity> userList;
  final String errorMessage;
  final int countryId;
  final bool lastPage;
  final int page;

  const TopUserState({
    required this.totalCount,
    required this.loading,
    required this.userList,
    required this.errorMessage,
    required this.countryId,
    required this.lastPage,
    required this.page,
  });

  factory TopUserState.initial() => const TopUserState(
        loading: true,
        userList: [],
        errorMessage: '',
        totalCount: 0,
        countryId: 1,
        lastPage: false,
        page: 1,
      );

  @override
  List<Object?> get props => [
        loading,
        userList,
        errorMessage,
        totalCount,
        countryId,
        lastPage,
      ];
  TopUserState copyWith({
    bool? loading,
    List<UserEntity>? userList,
    String? errorMessage,
    List<CountryEntity>? countryList,
    int? totalCount,
    int? countryId,
    bool? lastPage,
    int? page,
  }) =>
      TopUserState(
        userList: userList ?? this.userList,
        loading: loading ?? this.loading,
        errorMessage: errorMessage ?? this.errorMessage,
        countryId: countryId ?? this.countryId,
        totalCount: totalCount ?? this.totalCount,
        lastPage: lastPage ?? this.lastPage,
        page: page ?? this.page,
      );
}
