import 'dart:convert';

import 'package:github_favs/core/data/exception/app_exception.dart';
import 'package:github_favs/core/data/model/api_response_model.dart';

abstract class Converter<From, To> {
  To convert(From from);
}

abstract class ConverterImpl<From, To> extends Converter<From, To> {
  To runThroughParsingExceptionCatcher(To Function() f) {
    try {
      final to = f();
      return to;
    } on Exception {
      throw const AppException.parsingException();
    }
  }
}

abstract class ApiResponseModelConverter<TOutModel>
    extends ConverterImpl<ApiResponseModel, TOutModel> {
  final decode = jsonDecode;
}
