import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:github_favs/core/domain/usecase/usecase.dart';
import 'package:github_favs/feature/top_user/domain/entity/user_details.dart';
import 'package:github_favs/feature/top_user/domain/usecase/get_user_details.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/user_details/user_details_state.dart';

class UserDetailsBloc extends Cubit<UserDetailsSate> {
  UserDetailsBloc({
    required Usecase<GetUserDetailsInputParams, UserDetails> userDetailsUC,
  })  : _userDetailsUC = userDetailsUC,
        super(const UserDetailsSate.initial());
  final Usecase<GetUserDetailsInputParams, UserDetails> _userDetailsUC;

  Future<void> populateUserDetails(int id) async {
    emit(const UserDetailsSate.loading());
    final userDetailsEither = await _userDetailsUC(
      inParams: GetUserDetailsInputParams()..id = id,
    );
    userDetailsEither.fold(
      (l) => _onFailure(l),
      (r) => _onDetailsLoaded(r),
    );
  }

  _onDetailsLoaded(UserDetails r) {
    emit(UserDetailsSate.loaded(userDetails: r));
  }

  _onFailure(Failure l) {
    emit(
      UserDetailsSate.error(message: l.message),
    );
  }
}
