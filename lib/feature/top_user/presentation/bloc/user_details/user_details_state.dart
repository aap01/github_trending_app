import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_favs/feature/top_user/domain/entity/user_details.dart';
part 'user_details_state.freezed.dart';

@Freezed()
class UserDetailsSate with _$UserDetailsSate {
  const factory UserDetailsSate.initial() = _UserDetailsStateInitial;
  const factory UserDetailsSate.loading() = _UserDetailsStateLoading;
  const factory UserDetailsSate.loaded({
    required UserDetails userDetails,
  }) = _UserDetailsStateLoaded;
  const factory UserDetailsSate.error({
    required String message,
  }) = _UserDetailsStateError;
}
