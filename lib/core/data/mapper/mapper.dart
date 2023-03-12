import 'package:github_favs/core/data/exception/app_exception.dart';
import 'package:github_favs/core/domain/failure/failure.dart';

abstract class Mapper<From, To> {
  To map(From from);
}

abstract class MapperImpl<From, To> extends Mapper<From, To> {
  To runThroughMappingExceptionCatcher(To Function() f) {
    try {
      final to = f();
      return to;
    } on Exception {
      throw const AppException.mappingException();
    }
  }
}

class ExceptionToFailureMapperImpl implements Mapper<AppException, Failure> {
  @override
  Failure map(AppException from) {
    return from.when(
      noInternetException: () => const Failure.noInternetFailure(),
      serverException: () => const Failure.serverFailure(),
      parsingException: () => const Failure.unknownFailure(),
      mappingException: () => const Failure.unknownFailure(),
      cacheException: () => const Failure.unknownFailure(
        message: 'Data not found in local cache',
      ),
    );
  }
}
