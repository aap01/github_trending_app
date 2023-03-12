import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:github_favs/core/domain/usecase/usecase.dart';
import 'package:github_favs/feature/common/domain/repository/user_repository.dart';
import 'package:github_favs/feature/top_user/domain/entity/user_details.dart';

class GetUserDetailsInputParams with EntityParams {}

class GetUserDetails extends Usecase<GetUserDetailsInputParams, UserDetails> {
  final UserRepository _userRepository;

  GetUserDetails({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;
  @override
  Future<Either<Failure, UserDetails>> call({
    required GetUserDetailsInputParams inParams,
  }) =>
      _userRepository.getUserDetailsById(
        id: inParams.id,
      );
}
