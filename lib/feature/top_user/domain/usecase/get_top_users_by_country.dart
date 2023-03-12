import 'package:github_favs/core/domain/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:github_favs/core/domain/usecase/usecase.dart';
import 'package:github_favs/feature/common/domain/entity/user_list.dart';
import 'package:github_favs/feature/common/domain/repository/user_repository.dart';
import 'package:github_favs/feature/top_user/domain/repository/country_repository.dart';

class GetUsersByCountryInputParams with EntityParams, PaginatedInputParams {}

class GetTopUsersByCountry
    extends Usecase<GetUsersByCountryInputParams, UserList> {
  final CountryRepository _countryRepository;
  final UserRepository _userRepository;

  GetTopUsersByCountry({
    required CountryRepository countryRepository,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        _countryRepository = countryRepository;
  @override
  Future<Either<Failure, UserList>> call({
    required GetUsersByCountryInputParams inParams,
  }) async {
    final country = await _countryRepository.getById(
      id: inParams.id,
    );
    return country.fold(
      (l) => Left(l),
      (r) => _userRepository.getPagedListByCountry(
        count: inParams.count,
        page: inParams.page,
        countryName: r.name,
      ),
    );
  }
}
