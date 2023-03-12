import 'package:dartz/dartz.dart';
import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:github_favs/feature/common/domain/entity/user_list.dart';
import 'package:github_favs/feature/top_user/domain/entity/user_details.dart';

abstract class UserRepository {
  Future<Either<Failure, UserList>> getPagedListByCountry({
    required int count,
    required int page,
    required String countryName,
  });
  Future<Either<Failure, UserDetails>> getUserDetailsById({
    required int id,
  });
}
