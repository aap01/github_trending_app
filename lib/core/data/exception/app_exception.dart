import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_exception.freezed.dart';

@freezed
abstract class AppException with _$AppException {
  const factory AppException.noInternetException() = _NoInternetException;
  const factory AppException.serverException() = _ServerException;
  const factory AppException.parsingException() = _ParsingException;
  const factory AppException.mappingException() = _MappingException;
  const factory AppException.cacheException() = _CacheException;
}
