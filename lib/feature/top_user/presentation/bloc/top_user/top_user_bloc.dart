import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:github_favs/core/domain/usecase/usecase.dart';
import 'package:github_favs/feature/common/domain/entity/user_list.dart';
import 'package:github_favs/feature/top_user/domain/usecase/get_top_users_by_country.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/top_user/top_user_state.dart';

class TopUserBloc extends Cubit<TopUserState> {
  TopUserBloc({
    required Usecase<GetUsersByCountryInputParams, UserList> userListUC,
  })  : _userListUC = userListUC,
        super(TopUserState.initial());
  final Usecase<GetUsersByCountryInputParams, UserList> _userListUC;
  static const _count = 10;

  Future<void> setCountry(
    int countryId,
  ) async {
    if (state.countryId != countryId) {
      emit(TopUserState.initial().copyWith(countryId: countryId));
      loadInitialUserList();
    }
  }

  Future<void> loadInitialUserList() async {
    emit(state.copyWith(loading: true));
    final countryListEither = await _userListUC(
      inParams: GetUsersByCountryInputParams()
        ..page = state.page
        ..id = state.countryId
        ..count = _count,
    );
    emit(state.copyWith(loading: false));
    countryListEither.fold(
      (l) => _onFailure(l),
      (r) {
        _onUserListLoaded(r);
      },
    );
  }

  void _onUserListLoaded(UserList list) {
    final lastPage = list.items.length < _count;
    emit(
      state.copyWith(
        userList: list.items,
        totalCount: list.totalCount,
        lastPage: lastPage,
        errorMessage: '',
        page: state.page + 1,
      ),
    );
  }

  void _onFailure(Failure failure) {
    emit(state.copyWith(errorMessage: failure.message));
  }

  Future<void> loadMoreUsers() async {
    if (!state.lastPage) {
      final page = state.page + 1;
      emit(
        state.copyWith(
          loading: true,
        ),
      );
      final userListEither = await _userListUC(
        inParams: GetUsersByCountryInputParams()
          ..page = page
          ..id = state.countryId
          ..count = _count,
      );

      userListEither.fold((l) => _onFailure(l), (r) {
        _onUserListLoaded(r);
      });
    }
  }
}
