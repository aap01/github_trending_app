import 'package:dartz/dartz.dart';
import 'package:github_favs/core/domain/failure/failure.dart';

mixin PaginatedInputParams {
  int count = 10;
  int page = 1;
}

mixin EntityParams {
  late final int id;
}

class NoParams {
  const NoParams();
}

abstract class Usecase<InParams, OutParams> {
  Future<Either<Failure, OutParams>> call({
    required InParams inParams,
  });
}
