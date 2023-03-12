import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:github_favs/core/domain/usecase/usecase.dart';
import 'package:github_favs/feature/top_user/domain/entity/country_entity.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/country_list/country_list_state.dart';

class CountryListBloc extends Cubit<CountryListState> {
  CountryListBloc({
    required Usecase<NoParams, List<CountryEntity>> countryListUC,
  })  : _countryListUC = countryListUC,
        super(CountryListState.initial());

  final Usecase<NoParams, List<CountryEntity>> _countryListUC;
  Future<void> populateCountryList() async {
    emit(state.copyWith(loading: true));
    final countryListEither = await _countryListUC(inParams: const NoParams());
    emit(
      state.copyWith(loading: false),
    );
    countryListEither.fold(
      (l) => _onFailure(l),
      (r) => _onSuccess(r),
    );
  }

  void _onFailure(Failure failure) {
    emit(state.copyWith(errorMessage: failure.message));
  }

  _onSuccess(List<CountryEntity> r) {
    emit(
      state.copyWith(
        countryList: r,
      ),
    );
  }
}
