import 'package:equatable/equatable.dart';
import 'package:github_favs/feature/top_user/domain/entity/country_entity.dart';

class CountryListState extends Equatable {
  final bool loading;
  final List<CountryEntity> countryList;
  final String errorMessage;

  const CountryListState({
    required this.loading,
    required this.countryList,
    required this.errorMessage,
  });

  factory CountryListState.initial() => CountryListState(
        loading: true,
        countryList: List.empty(),
        errorMessage: '',
      );

  @override
  List<Object?> get props => [
        loading,
        countryList,
        errorMessage,
      ];

  CountryListState copyWith({
    bool? loading,
    List<CountryEntity>? countryList,
    String? errorMessage,
  }) =>
      CountryListState(
        loading: loading ?? this.loading,
        countryList: countryList ?? this.countryList,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
