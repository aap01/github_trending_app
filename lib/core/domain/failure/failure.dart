import 'package:freezed_annotation/freezed_annotation.dart';
part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.serverFailure({
    @Default('Server is not responding. Please try again later') String message,
  }) = _ServerFailure;
  const factory Failure.noInternetFailure({
    @Default('Please turn on your internet and try again') String message,
  }) = _NoInternetFailure;
  const factory Failure.unknownFailure({
    @Default('Something went wrong! Please try again later') String message,
  }) = _UnknownFailure;
}
